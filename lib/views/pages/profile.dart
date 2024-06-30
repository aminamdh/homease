import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/models/profile_model.dart';
import 'package:homease/core/services/api_service.dart';
import 'package:homease/core/services/getStorage.dart';

import 'package:homease/views/widgets/text.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditingUsername = false;
  bool _isEditingPassword = false;
  String _username = "default_username"; // Add a default or initial value
  String _password = "••••••••"; // For display purposes
  String _language = "en_US"; // Add a default language
  String _email = "";
  String _about = "";
  String _image = "";
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  void _fetchProfile() async {
    try {
      final ApiService apiService = ApiService();
      final profileData = await apiService.getProfile();
      final profile = Profile.fromJson(profileData['profile']);
      setState(() {
        _username = profile.username;
        _email = profile.email;
        _about = profile.about;
        _image = profile.image;
        _errorMessage = ""; // Clear any previous error messages
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to fetch profile: $e";
      });
    }
  }

  void _logout() async {
    try {
      final ApiService apiService = ApiService();
      await apiService.logout();
      gsService.deleteToken(); // Clear token
      Get.offAllNamed('/login'); // Replace with your login route
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to logout: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: 'account_settings'.tr, clr: AppTheme.primaryColor),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 2.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.0),
                  AppTheme.primaryColor.withOpacity(0.5),
                  AppTheme.primaryColor,
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
                if (_errorMessage.isNotEmpty) // Display error message if exists
                  ListTile(
                    title: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ListTile(
                  leading: _image.isNotEmpty
                      ? CircleAvatar(backgroundImage: NetworkImage(_image))
                      : CircleAvatar(child: Icon(Icons.person)),
                  title: Header3(
                    txt: 'username'.tr,
                    clr: _isEditingUsername ? AppTheme.primaryColor : AppTheme.black,
                  ),
                  subtitle: Header4(txt: _username),
                  trailing: Icon(Icons.edit, color: AppTheme.primaryColor),
                  onTap: () => _editUsername(context),
                ),
                ListTile(
                  title: Header3(txt: 'email'.tr, clr: AppTheme.black),
                  subtitle: Header4(txt: _email),
                ),
                ListTile(
                  title: Header3(txt: 'about'.tr, clr: AppTheme.black),
                  subtitle: Header4(txt: _about),
                ),
                ListTile(
                  title: Header3(
                    txt: 'password'.tr,
                    clr: _isEditingPassword ? AppTheme.primaryColor : AppTheme.black,
                  ),
                  subtitle: Header4(txt: "••••••••"),
                  trailing: Icon(Icons.edit, color: AppTheme.primaryColor),
                  onTap: () => _editPassword(context),
                ),
                ListTile(
                  title: Header3(txt: 'language'.tr, clr: AppTheme.black),
                  subtitle: Header4(txt: _language),
                  trailing: Icon(Icons.arrow_drop_down, color: AppTheme.primaryColor),
                  onTap: () => _selectLanguage(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _editUsername(BuildContext context) {
    setState(() {
      _isEditingUsername = true;
    });

    TextEditingController usernameController = TextEditingController(text: _username);
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
              setState(() {
                _username = usernameController.text;
                _isEditingUsername = false;
              });
              Navigator.of(context).pop();
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

  void _editPassword(BuildContext context) {
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
              setState(() {
                _password = passwordController.text;
                _isEditingPassword = false;
              });
              Navigator.of(context).pop();
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

  void _selectLanguage(BuildContext context) {
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
                      groupValue: _language,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _language = value;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      activeColor: AppTheme.primaryColor,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
