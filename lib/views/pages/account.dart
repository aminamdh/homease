import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/settings_controller.dart';
import 'package:homease/views/widgets/text.dart';

class AccountSettingsPage extends StatefulWidget {
  AccountSettingsPage() {
    if (!Get.isRegistered<SettingsController>()) {
      Get.put(SettingsController());
    }
  }

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  bool _isEditingUsername = false;
  bool _isEditingPassword = false;

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find<SettingsController>();

    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: 'account_settings'.tr, clr: AppTheme.primaryColor),
      ),
      body: Column(
        children: [
          // Add the faded line here
          Container(
            height: 2.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.0), // Transparent color at the top
                  AppTheme.primaryColor.withOpacity(0.5),
                  AppTheme.primaryColor, // Solid color at the bottom
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                ListTile(
                  title: Header3(
                    txt: 'username'.tr,
                    clr: _isEditingUsername ? AppTheme.primaryColor : AppTheme.black,
                  ),
                  subtitle: Header4(txt: settingsController.username.value),
                  trailing: Icon(Icons.edit, color: AppTheme.primaryColor),
                  onTap: () => _editUsername(context, settingsController),
                ),
                ListTile(
                  title: Header3(
                    txt: 'password'.tr,
                    clr: _isEditingPassword ? AppTheme.primaryColor : AppTheme.black,
                  ),
                  subtitle: Header4(txt: "••••••••"),
                  trailing: Icon(Icons.edit, color: AppTheme.primaryColor),
                  onTap: () => _editPassword(context, settingsController),
                ),
                ListTile(
                  title: Header3(txt: 'language'.tr, clr: AppTheme.black),
                  subtitle: Header4(txt: settingsController.language.value),
                  trailing: Icon(Icons.arrow_drop_down, color: AppTheme.primaryColor),
                  onTap: () => _selectLanguage(context, settingsController),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _editUsername(BuildContext context, SettingsController settingsController) {
    setState(() {
      _isEditingUsername = true;
    });

    TextEditingController usernameController = TextEditingController(text: settingsController.username.value);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Header3(txt: 'edit_username'.tr),
        content: TextField(
          controller: usernameController,
          decoration: InputDecoration(
            labelText: 'username'.tr,
            labelStyle: TextStyle(color: AppTheme.black),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryColor),
            ),
          ),
          cursorColor: AppTheme.primaryColor,
        ),
        actions: [
          TextButton(
            onPressed: () {
              settingsController.updateUsername(usernameController.text);
              Navigator.of(context).pop();
              setState(() {
                _isEditingUsername = false;
              });
            },
            child: Header4(txt: 'save'.tr, clr: AppTheme.primaryColor),
          ),
        ],
      ),
    ).then((_) {
      setState(() {
        _isEditingUsername = false;
      });
    });
  }

  void _editPassword(BuildContext context, SettingsController settingsController) {
    setState(() {
      _isEditingPassword = true;
    });

    TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Header3(txt: 'edit_password'.tr),
        content: TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'password'.tr,
            labelStyle: TextStyle(color: AppTheme.black),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryColor),
            ),
          ),
          obscureText: true,
          cursorColor: AppTheme.primaryColor,
        ),
        actions: [
          TextButton(
            onPressed: () {
              settingsController.updatePassword(passwordController.text);
              Navigator.of(context).pop();
              setState(() {
                _isEditingPassword = false;
              });
            },
            child: Header4(txt: 'save'.tr, clr: AppTheme.primaryColor),
          ),
        ],
      ),
    ).then((_) {
      setState(() {
        _isEditingPassword = false;
      });
    });
  }

  void _selectLanguage(BuildContext context, SettingsController settingsController) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Header3(txt: 'select_language'.tr, clr: AppTheme.black),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <String>['en_US', 'ar_AR', 'fr_FR']
                .map((String language) => RadioListTile<String>(
                      title: Header3(txt: language.tr, clr: AppTheme.black),
                      value: language,
                      groupValue: settingsController.language.value,
                      onChanged: (value) {
                        if (value != null) {
                          settingsController.changeLanguage(value);
                          Navigator.of(context).pop();
                        }
                      },
                      activeColor: AppTheme.primaryColor, // Set the active color here
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
