import 'package:homease/core/models/user_model.dart';

class AuthController {
  User user = User(
    username: '',
    password: '',
    name: '',
    familyName: '',
    wilaya: '',
    residenceName: '',
    blocNumber: '',
    houseNumber: '',
    phoneNumber: '',
  );

  bool isUsernameValid = true;
  bool isPasswordValid = true;
  bool isNameValid = true;
  bool isFamilyNameValid = true;
  bool isWilayaValid = true;
  bool isResidenceNameValid = true;
  bool isBlocNumberValid = true;
  bool isHouseNumberValid = true;
  bool isPhoneNumberValid = true;

  bool _loggedIn = false; // Internal state to track login status

  bool get isLoggedIn => _loggedIn;

  void setUserProperty(String property, String value) {
    switch (property) {
      case 'username':
        user.username = value;
        break;
      case 'password':
        user.password = value;
        break;
      case 'name':
        user.name = value;
        break;
      case 'familyName':
        user.familyName = value;
        break;
      case 'wilaya':
        user.wilaya = value;
        break;
      case 'residenceName':
        user.residenceName = value;
        break;
      case 'blocNumber':
        user.blocNumber = value;
        break;
      case 'houseNumber':
        user.houseNumber = value;
        break;
      case 'phoneNumber':
        user.phoneNumber = value;
        break;
      default:
        throw Exception('Invalid property name');
    }
  }

  bool validateProperty(String property) {
    switch (property) {
      case 'username':
        isUsernameValid = user.username.isNotEmpty;
        return isUsernameValid;
      case 'password':
        isPasswordValid = user.password.isNotEmpty;
        return isPasswordValid;
      case 'name':
        isNameValid = user.name.isNotEmpty;
        return isNameValid;
      case 'familyName':
        isFamilyNameValid = user.familyName.isNotEmpty;
        return isFamilyNameValid;
      case 'wilaya':
        isWilayaValid = user.wilaya.isNotEmpty;
        return isWilayaValid;
      case 'residenceName':
        isResidenceNameValid = user.residenceName.isNotEmpty;
        return isResidenceNameValid;
      case 'blocNumber':
        isBlocNumberValid = user.blocNumber.isNotEmpty;
        return isBlocNumberValid;
      case 'houseNumber':
        isHouseNumberValid = user.houseNumber.isNotEmpty;
        return isHouseNumberValid;
      case 'phoneNumber':
        isPhoneNumberValid = user.phoneNumber.isNotEmpty;
        return isPhoneNumberValid;
      default:
        throw Exception('Invalid property name');
    }
  }

  void login() {
    if (validateProperty('username') && validateProperty('password')) {
      _loggedIn = true;  // Set login status to true
      print('Username: ${user.username}');
      print('Password: ${user.password}');
    }
  }

  void logout() {
    _loggedIn = false;  // Set login status to false
  }

  void register() {
    if (validateProperty('username') &&
        validateProperty('password') &&
        validateProperty('name') &&
        validateProperty('familyName') &&
        validateProperty('wilaya') &&
        validateProperty('residenceName') &&
        validateProperty('blocNumber') &&
        validateProperty('houseNumber') &&
        validateProperty('phoneNumber')) {
      print('Registration Details:');
      print('Username: ${user.username}');
      print('Password: ${user.password}');
      print('Name: ${user.name}');
      print('Family Name: ${user.familyName}');
      print('Wilaya: ${user.wilaya}');
      print('Residence Name: ${user.residenceName}');
      print('Bloc Number: ${user.blocNumber}');
      print('House Number: ${user.houseNumber}');
      print('Phone Number: ${user.phoneNumber}');
    }
  }
}
