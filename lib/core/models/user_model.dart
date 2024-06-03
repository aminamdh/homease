import 'dart:convert';

class User {
  String username;
  String password;
  String name;
  String familyName;
  String wilaya;
  String residenceName;
  String blocNumber;
  String houseNumber;
  String phoneNumber;

  User({
    required this.username,
    required this.password,
    required this.name,
    required this.familyName,
    required this.wilaya,
    required this.residenceName,
    required this.blocNumber,
    required this.houseNumber,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      name: json['name'],
      familyName: json['familyName'],
      wilaya: json['wilaya'],
      residenceName: json['residenceName'],
      blocNumber: json['blocNumber'],
      houseNumber: json['houseNumber'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'familyName': familyName,
      'wilaya': wilaya,
      'residenceName': residenceName,
      'blocNumber': blocNumber,
      'houseNumber': houseNumber,
      'phoneNumber': phoneNumber,
    };
  }
}
