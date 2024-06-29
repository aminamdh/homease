import 'package:get/get.dart';
import 'package:homease/core/models/user_model.dart';
import 'package:homease/core/services/api_service.dart';

class AuthController extends GetxController {
  final ApiService apiService = ApiService();

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
  bool _loggedIn = false;

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
        final response = await apiService.login(user.email, user.password);
        if (response.isNotEmpty) {
          user = User.fromJson(response);
          _loggedIn = true;
          print('Login successful');
        } else {
          _loggedIn = false;
          print('Login failed');
        }
      } catch (e) {
        _loggedIn = false;
        print('Login error: $e');
      }
    }
  }

  void logout() {
    _loggedIn = false;
  }
}
