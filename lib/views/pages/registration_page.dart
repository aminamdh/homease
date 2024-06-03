import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/auth_controller.dart';
import 'package:homease/views/pages/home.dart';
import 'package:homease/views/widgets/text.dart';
import 'package:sizer/sizer.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: "Registration",clr: AppTheme.primaryColor,),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, -10),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 30.w,
                  height: 20.h,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextField(
                      label: "Username",
                      errormessage: authController.isUsernameValid
                          ? null
                          : "Enter Username",
                      onChanged: (value) {
                        authController.setUserProperty('username', value);
                      },
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      obscureText: true,
                      label: "Password",
                      errormessage: authController.isPasswordValid
                          ? null
                          : "Enter Password",
                      onChanged: (value) {
                        authController.setUserProperty('password', value);
                      },
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      label: "Name",
                      errormessage: authController.isNameValid
                          ? null
                          : "Enter Name",
                      onChanged: (value) {
                        authController.setUserProperty('name', value);
                      },
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      label: "Family Name",
                      errormessage: authController.isFamilyNameValid
                          ? null
                          : "Enter Family Name",
                      onChanged: (value) {
                        authController.setUserProperty('familyName', value);
                      },
                    ),
                    SizedBox(height: 10),
                    MyDropdownField(
                      label: "Wilaya",
                      items: ['Wilaya 1', 'Wilaya 2', 'Wilaya 3'],
                      onChanged: (value) {
                        authController.setUserProperty('wilaya', value!);
                      },
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      label: "Residence Name",
                      errormessage: authController.isResidenceNameValid
                          ? null
                          : "Enter Residence Name",
                      onChanged: (value) {
                        authController.setUserProperty('residenceName', value);
                      },
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      label: "Bloc Number",
                      errormessage: authController.isBlocNumberValid
                          ? null
                          : "Enter Bloc Number",
                      onChanged: (value) {
                        authController.setUserProperty('blocNumber', value);
                      },
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      label: "House Number",
                      errormessage: authController.isHouseNumberValid
                          ? null
                          : "Enter House Number",
                      onChanged: (value) {
                        authController.setUserProperty('houseNumber', value);
                      },
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      label: "Phone Number",
                      errormessage: authController.isPhoneNumberValid
                          ? null
                          : "Enter Phone Number",
                      onChanged: (value) {
                        authController.setUserProperty('phoneNumber', value);
                      },
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          authController.register();
                          if (authController.isLoggedIn) {
                            Get.off(() => HomePage());
                          } else {
                            Get.snackbar(
                              'Registration failed',
                              'Please check your details',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Text(
                        'Register'.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.label,
    this.errormessage,
    required this.onChanged,
    this.obscureText = false,
  }) : super(key: key);

  final Function(String) onChanged;
  final String label;
  final String? errormessage;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: AppTheme.primaryColor,
        labelStyle: Get.textTheme.bodyLarge,
        labelText: label.tr,
        errorText: errormessage?.tr,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.primaryColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Get.theme.hintColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding:
            EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      style: Get.theme.textTheme.bodyLarge,
      onChanged: onChanged,
    );
  }
}

class MyDropdownField extends StatelessWidget {
  MyDropdownField({
    Key? key,
    required this.label,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final List<String> items;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
          borderSide: BorderSide(color: AppTheme.primaryColor), // Border color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor), // Field color
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor), // Field color
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
        ),
        contentPadding:
            EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        fillColor: Colors.white, // Field color
        filled: true,
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.tr),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
