import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/base_view.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  int _segundos = 0; // Tiempo transcurrido (puedes usar duración si prefieres cuenta regresiva)
  Timer? _timer;
  bool _enMarcha = false; // Indica si el cronómetro está corriendo
  bool _pausado = false; // Indica si está pausado

  // Inicia el cronómetro
  void _iniciar() {
    print("▶️ Iniciando cronómetro");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _segundos++;
      });
    });
    setState(() {
      _enMarcha = true;
      _pausado = false;
    });
  }

  // Pausa el cronómetro
  void _pausar() {
    print("⏸️ Pausando cronómetro en $_segundos s");
    _timer?.cancel();
    setState(() {
      _pausado = true;
    });
  }

  // Reanuda el cronómetro
  void _reanudar() {
    print("⏯️ Reanudando cronómetro desde $_segundos s");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _segundos++;
      });
    });
    setState(() {
      _pausado = false;
    });
  }

  // Reinicia el cronómetro
  void _reiniciar() {
    print("Reiniciando cronómetro");
    _timer?.cancel();
    setState(() {
      _segundos = 0;
      _enMarcha = false;
      _pausado = false;
    });
  }

  // Cancela el timer al salir (limpieza de recursos)
  @override
  void dispose() {
    print("🧹 Cancelando timer al salir de la vista");
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "Cronómetro con Timer",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tiempo grande estilo marcador
              Text(
                "${_segundos}s",
                style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Botones de control
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: !_enMarcha ? _iniciar : null,
                    child: const Text("Iniciar"),
                  ),
                  ElevatedButton(
                    onPressed: _enMarcha && !_pausado ? _pausar : null,
                    child: const Text("Pausar"),
                  ),
                  ElevatedButton(
                    onPressed: _pausado ? _reanudar : null,
                    child: const Text("Reanudar"),
                  ),
                  ElevatedButton(
                    onPressed: _enMarcha ? _reiniciar : null,
                    child: const Text("Reiniciar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
