import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/auth_controller.dart';
import 'package:homease/views/pages/home.dart';
import 'package:homease/views/pages/registration_page.dart';
import 'package:homease/views/widgets/text.dart';
import 'package:sizer/sizer.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: "Login",clr: AppTheme.primaryColor,),
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
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          authController.login();
                          if (authController.isLoggedIn) {
                            Get.off(() => HomePage());
                          } else {
                            Get.snackbar(
                              'Login failed',
                              'Please check your credentials',
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
                        'Login'.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Get.to(() => RegistrationPage());
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(color: AppTheme.primaryColor),
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
        prefixIcon: Icon(
          Icons.person,
          color: AppTheme.primaryColor,
        ),
        contentPadding:
            EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      style: Get.theme.textTheme.bodyLarge,
      onChanged: onChanged,
    );
  }
}
