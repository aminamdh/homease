class User {
  int? id;
  int? roleId;
  String username;
  String password;
  String email;
  String image;
  String about;
  String lastname;
  String dateOfBirth;
  String position;
  String salary;
  String startDate;
  String phone;
  String address;
  String createdAt;
  String updatedAt;
  String imageUrl;

  User({
    this.id,
    this.roleId,
    required this.username,
    required this.password,
    required this.email,
    required this.image,
    required this.about,
    required this.lastname,
    required this.dateOfBirth,
    required this.position,
    required this.salary,
    required this.startDate,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      roleId: json['role_id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      image: json['image'],
      about: json['about'],
      lastname: json['lastname'],
      dateOfBirth: json['date_of_birth'],
      position: json['position'],
      salary: json['salary'],
      startDate: json['start_date'],
      phone: json['phone'],
      address: json['address'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_id': roleId,
      'username': username,
      'password': password,
      'email': email,
      'image': image,
      'about': about,
      'lastname': lastname,
      'date_of_birth': dateOfBirth,
      'position': position,
      'salary': salary,
      'start_date': startDate,
      'phone': phone,
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_url': imageUrl,
    };
  }
}
