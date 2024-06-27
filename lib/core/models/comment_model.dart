class Comment {
  final int id;
  final int postId;
  final int userId;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['post_id'],
      userId: json['user_id'],
      body: json['body'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
