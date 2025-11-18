// services/sync_service.dart
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../data/local/task_local_datasource.dart';
import '../data/remote/task_remote_datasource.dart';
import '../models/task.dart';

final _logger = Logger();

class SyncService {
  final TaskLocalDataSource local;
  final TaskRemoteDataSource remote;
  final _uuid = const Uuid();

  Timer? _timer;
  bool _running = false;

  SyncService({required this.local, required this.remote});

  // -------------------------------------------------------------
  // AUTO-SYNC (cada X segundos si hay internet)
  // -------------------------------------------------------------
  void startAutoSync({int intervalSeconds = 8}) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: intervalSeconds), (_) async {
      final conn = await Connectivity().checkConnectivity();
      if (conn != ConnectivityResult.none) {
        await syncQueue();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _running = false;
  }

  // -------------------------------------------------------------
  // PROCESAR COLA
  // -------------------------------------------------------------
  Future<void> syncQueue() async {
    if (_running) return;
    _running = true;

    final queue = await local.getQueue();

    for (final op in queue) {
      final opId = op['id'] as String;
      final opType = op['op'] as String;
      final entityId = op['entity_id'] as String;
      final payload = op['payload'] as String;
      int attempt = (op['attempt_count'] ?? 0) as int;

      _logger.i("Processing queue item: $opId type:$opType attempt:$attempt");

      TaskModel? model;

      // ---------------------------------------------------------
      // PARSEAR PAYLOAD DE MANERA SEGURA
      // ---------------------------------------------------------
      if (opType != 'DELETE') {
        try {
          model = TaskModel.fromJson(jsonDecode(payload));
        } catch (e) {
          _logger.e("Payload corrupt, removing op:$opId → $e");
          await local.removeQueueItem(opId);
          continue;
        }
      }

      // ---------------------------------------------------------
      // NO PERMITIR UPDATE SIN ID
      // ---------------------------------------------------------
      if (opType == 'UPDATE' && (model?.id.isEmpty ?? true)) {
        _logger.e("UPDATE blocked: Task without ID. Removing op:$opId");
        await local.removeQueueItem(opId);
        continue;
      }

      try {
        // ---------------------------------------------------------
        // CREATE
        // ---------------------------------------------------------
        if (opType == 'CREATE') {
          try {
            await remote.createTask(model!, idempotencyKey: opId);
          } catch (e) {
            final msg = e.toString();

            // Crear idempotente: si ya existió → éxito
            if (msg.contains("ID already exists")) {
              _logger.w("CREATE already processed. Removing op:$opId");
              await local.removeQueueItem(opId);
              continue;
            }

            rethrow;
          }
        }

        // ---------------------------------------------------------
        // UPDATE
        // ---------------------------------------------------------
        else if (opType == 'UPDATE') {
          await remote.updateTask(model!);
        }

        // ---------------------------------------------------------
        // DELETE
        // ---------------------------------------------------------
        else if (opType == 'DELETE') {
          try {
            await remote.deleteTask(entityId);
          } catch (e) {
            final msg = e.toString();

            // DELETE idempotente: si ya no existe → éxito
            if (msg.contains("404")) {
              _logger.w("DELETE already applied. Removing op:$opId");
              await local.removeQueueItem(opId);
              continue;
            }

            rethrow;
          }
        }

        // ---------------------------------------------------------
        // ÉXITO → eliminar de la cola
        // ---------------------------------------------------------
        await local.removeQueueItem(opId);
        _logger.i("Sync success op:$opId");
      }

      // -----------------------------------------------------------
      // ERRORES CON BACKOFF
      // -----------------------------------------------------------
      catch (e) {
        attempt += 1;

        final backoffMs = _calculateBackoff(attempt);

        await local.updateQueueAttempt(opId, attempt, e.toString());
        _logger.w(
            'Sync failed op:$opId attempt:$attempt error:$e → retry after ${backoffMs}ms');

        if (attempt >= 5) {
          _logger.e("Op $opId failed permanently (max attempts reached)");
          // Se mantiene en cola para debug o decisión futura
        } else {
          await Future.delayed(Duration(milliseconds: backoffMs));
        }
      }
    }

    _running = false;
  }

  // -------------------------------------------------------------
  // BACKOFF EXPONENCIAL
  // -------------------------------------------------------------
  int _calculateBackoff(int attempt) {
    final base = 500;
    final jitter = Random().nextInt(300);
    return (base * pow(2, attempt)).toInt() + jitter;
  }
}
