// data/queue/queue_operation.dart
class QueueOperation {
  final String id;
  final String entity;
  final String entityId;
  final String op;
  final String payload;
  final int createdAt;
  final int attemptCount;
  final String? lastError;

  QueueOperation({
    required this.id,
    required this.entity,
    required this.entityId,
    required this.op,
    required this.payload,
    required this.createdAt,
    this.attemptCount = 0,
    this.lastError,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'entity': entity,
        'entity_id': entityId,
        'op': op,
        'payload': payload,
        'created_at': createdAt,
        'attempt_count': attemptCount,
        'last_error': lastError
      };
}
