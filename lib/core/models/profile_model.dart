class Profile {
  String name;
  String username;
  String email;
  String about;
  String image;

  Profile({
    required this.name,
    required this.username,
    required this.email,
    required this.about,
    required this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      about: json['about'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'about': about,
      'image': image,
    };
  }
}
