class News {
  final int id;
  final int userId;
  final String title;
  final String slug;
  final String imageUrl; // Utiliser cette clé pour l'URL de l'image
  final String body;
  final int viewCount;
  final int status;
  final int isApproved;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  News({
    required this.id,
    required this.userId,
    required this.title,
    required this.slug,
    required this.imageUrl,
    required this.body,
    required this.viewCount,
    required this.status,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      slug: json['slug'],
      imageUrl: json['image_url'], // Utiliser image_url ici
      body: json['body'],
      viewCount: json['view_count'],
      status: json['status'],
      isApproved: json['is_approved'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final int roleId;
  final String name;
  final String username;
  final String email;
  final String image;
  final String about;

  User({
    required this.id,
    required this.roleId,
    required this.name,
    required this.username,
    required this.email,
    required this.image,
    required this.about,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      roleId: json['role_id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      image: json['image'],
      about: json['about'],
    );
  }

  String get fullImageUrl {
    return 'http://homease.tech/api/storage/$image';
  }
}
