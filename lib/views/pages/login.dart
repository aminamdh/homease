import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/auth_controller.dart';
import 'package:homease/views/pages/home.dart';
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
        title: Header2(txt: 'login'.tr, clr: AppTheme.primaryColor),
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
                      label: 'email'.tr,
                      errormessage: authController.isEmailValid
                          ? null
                          : 'enter_email'.tr,
                      onChanged: (value) {
                        authController.setUserProperty('email', value);
                      },
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      obscureText: true,
                      label: 'password'.tr,
                      errormessage: authController.isPasswordValid
                          ? null
                          : 'enter_password'.tr,
                      onChanged: (value) {
                        authController.setUserProperty('password', value);
                      },
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          await authController.login();
                          if (authController.isLoggedIn) {
                            Get.off(() => HomePage());
                          } else {
                            Get.snackbar(
                              'login_failed'.tr,
                              'check_credentials'.tr,
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
                        'login'.tr,
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
