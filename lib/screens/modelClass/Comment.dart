class Comment {
  final String userId;
  final String comment;
  final DateTime timestamp;

  Comment({
    required this.userId,
    required this.comment,
    required this.timestamp,
  });

  factory Comment.fromMap(Map<String, dynamic> data) {
    return Comment(
      userId: data['userId'],
      comment: data['comment'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
    );
  }
}
