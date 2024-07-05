import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/complaint_controller.dart';
import 'package:homease/views/pages/complaint_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:homease/core/models/complaint.dart';
import 'package:uuid/uuid.dart';

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  ComplaintFormState createState() => ComplaintFormState();
}

class ComplaintFormState extends State<ComplaintForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ComplaintController _complaintController = Get.find();
  final ImagePicker _picker = ImagePicker();
  final Uuid _uuid = Uuid();

  late String _address;
  late String _status;
  late String _description;
  late String _responsible;
  late String _priority;
  late String _category;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _address = '';
    _status = 'open';
    _description = '';
    _responsible = 'Electrician';
    _priority = 'Low';
    _category = 'Problèmes de plomberie';
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _selectedImage = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final complaint = Complaint(
        id: _uuid.v4(),
        address: _address,
        description: _description,
        status: _status,
        responsible: _responsible,
        priority: _priority,
        category: _category,
        attachmentUrl: _selectedImage?.path,
      );

      _complaintController.addComplaint(complaint).then((_) {
        Get.to(() => ComplaintListPage());
      }).catchError((error) {
        print("Error adding complaint: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primaryColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              SizedBox(height: 16.0, width: 12,),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primaryColor),
                  ),
                ),
                value: _category,
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                },
                items: <String>[
                  'Problèmes de plomberie',
                  'Problèmes électriques',
                  'Problèmes structurels',
                  'Chauffage et Ventilation et Climatisation',
                  'Lutte contre les nuisibles',
                  'Problèmes de sécurité',
                  'Paysage et entretien des terrains',
                  'Gestion des déchets',
                  'Gestion du stationnement et de la circulation',
                  'Espaces communs et commodités',
                  'Plaintes pour nuisances sonores',
                  'Sécurité incendie',
                  'Approvisionnement en eau',
                  'Entretien des ascenseurs',
                  'Services Internet et câble',
                  'Éclairage',
                  'Nettoyage et assainissement',
                  'Accessibilité',
                  'Réclamations'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Priority',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primaryColor),
                  ),
                ),
                value: _priority,
                onChanged: (String? newValue) {
                  setState(() {
                    _priority = newValue!;
                  });
                },
                items: <String>[
                  'Low',
                  'Medium',
                  'High'
                ].map<DropdownMenuItem<String>>((String value) {
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
                  labelText: 'Description',
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
                    return 'Please enter description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 16.0),
              if (_selectedImage != null)
                Column(
                  children: [
                    Image.file(_selectedImage!, height: 200),
                    TextButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text("Remove"),
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
                  labelText: 'Responsible',
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: submitForm,
                child: Text('Submit Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
