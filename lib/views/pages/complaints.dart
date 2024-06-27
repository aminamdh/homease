import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/complaint_controller.dart';
import 'package:homease/views/pages/complaint_list.dart';
import 'package:homease/core/models/complaint.dart';
import 'package:homease/views/widgets/text.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: 'complaints'.tr, clr: AppTheme.primaryColor),
        actions: [
          IconButton(
            icon: Icon(Icons.list, color: AppTheme.primaryColor),
            onPressed: () {
              Get.to(() => ComplaintListPage());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Faded line between AppBar and body
          Container(
            height: 1.0,
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ComplaintForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ComplaintController _complaintController = Get.find();
  final ImagePicker _picker = ImagePicker();

  String _userName = '';
  String _blocNumber = '';
  String _complaintName = '';
  String _complaintState = 'Normal';
  String _complaintDescription = '';
  String _responsible = 'Electrician';
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _selectedImage = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'username'.tr,
              labelStyle: TextStyle(color: AppTheme.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'enter_username'.tr;
              }
              return null;
            },
            onSaved: (value) {
              _userName = value!;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'bloc_number'.tr,
              labelStyle: TextStyle(color: AppTheme.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'enter_bloc_number'.tr;
              }
              return null;
            },
            onSaved: (value) {
              _blocNumber = value!;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'complaint_name'.tr,
              labelStyle: TextStyle(color: AppTheme.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'enter_complaint_name'.tr;
              }
              return null;
            },
            onSaved: (value) {
              _complaintName = value!;
            },
          ),
          SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'complaint_state'.tr,
              labelStyle: TextStyle(color: AppTheme.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
            value: _complaintState,
            onChanged: (String? newValue) {
              setState(() {
                _complaintState = newValue!;
              });
            },
            items: <String>['Normal', 'Urgent', 'Highly Urgent']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'complaint_description'.tr,
              labelStyle: TextStyle(color: AppTheme.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'enter_complaint_description'.tr;
              }
              return null;
            },
            onSaved: (value) {
              _complaintDescription = value!;
            },
          ),
          SizedBox(height: 16.0),
          if (_selectedImage != null)
            Column(
              children: [
                Image.file(_selectedImage!, height: 200),
                TextButton.icon(
                  icon: Icon(Icons.delete, color: AppTheme.primaryColor),
                  label: Header4(txt: "remove".tr, clr: AppTheme.primaryColor),
                  onPressed: () {
                    setState(() {
                      _selectedImage = null;
                    });
                  },
                ),
              ],
            ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'responsible'.tr,
              labelStyle: TextStyle(color: AppTheme.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
            value: _responsible,
            onChanged: (String? newValue) {
              setState(() {
                _responsible = newValue!;
              });
            },
            items: <String>[
              'Electrician',
              'Plumber',
              'Agent',
              'None',
              'Other'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 32.0),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor, // Set the button color to primary color
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Create a complaint object
                  final complaint = Complaint(
                    userName: _userName,
                    blocNumber: _blocNumber,
                    complaintName: _complaintName,
                    complaintState: _complaintState,
                    complaintDescription: _complaintDescription,
                    responsible: _responsible,
                    attachedImage: _selectedImage?.path,
                  );
                  // Add the complaint to the controller
                  _complaintController.addComplaint(complaint);
                  // Navigate to complaint list page
                  Get.to(() => ComplaintListPage());
                }
              },
              child: Header4(txt: 'submit_complaint'.tr, clr: AppTheme.textFieledFillColor),
            ),
          ),
        ],
      ),
    );
  }
}
