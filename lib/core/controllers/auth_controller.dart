import 'package:homease/core/models/user_model.dart';
import 'package:dio/dio.dart';

class AuthController {
  User user = User(
    id: 0,
    roleId: 0,
    username: '',
    password: '',
    email: '',
    image: '',
    about: '',
    lastname: '',
    dateOfBirth: '',
    position: '',
    salary: '',
    startDate: '',
    phone: '',
    address: '',
    createdAt: '',
    updatedAt: '',
    imageUrl: '',
  );

  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool _loggedIn = false; // Internal state to track login status

  bool get isLoggedIn => _loggedIn;

  void setUserProperty(String property, String value) {
    switch (property) {
      case 'email':
        user.email = value;
        break;
      case 'password':
        user.password = value;
        break;
      default:
        throw Exception('Invalid property name');
    }
  }

  bool validateProperty(String property) {
    switch (property) {
      case 'email':
        isEmailValid = user.email.isNotEmpty;
        return isEmailValid;
      case 'password':
        isPasswordValid = user.password.isNotEmpty;
        return isPasswordValid;
      default:
        throw Exception('Invalid property name');
    }
  }

  Future<void> login() async {
    if (validateProperty('email') && validateProperty('password')) {
      try {
        final Dio dio = Dio();
        final response = await dio.post(
          'http://homease.tech/api/login',
          data: {
            'email': user.email,
            'password': user.password,
          },
        );
        
        if (response.statusCode == 200) {
          // Assuming the API returns user data on successful login
          final data = response.data;
          user = User.fromJson(data);
          _loggedIn = true;
          print('Login successful');
        } else {
          _loggedIn = false;
          print('Login failed: ${response.statusMessage}');
        }
      } catch (e) {
        _loggedIn = false;
        print('Login error: $e');
      }
    }
  }

  void logout() {
    _loggedIn = false;  // Set login status to false
  }
}
