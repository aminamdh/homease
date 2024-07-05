import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/complaint_controller.dart';
import 'package:homease/core/models/complaint.dart';
import 'package:homease/views/widgets/text.dart';

class UpdateComplaintPage extends StatefulWidget {
  final Complaint complaint;

  const UpdateComplaintPage({Key? key, required this.complaint}) : super(key: key);

  @override
  _UpdateComplaintPageState createState() => _UpdateComplaintPageState();
}

class _UpdateComplaintPageState extends State<UpdateComplaintPage> {
  final ComplaintController _complaintController = Get.find<ComplaintController>();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _addressController;
  late TextEditingController _descriptionController;
  String? _category;
  String? _priority;
  String? _responsible;
  String? _attachmentUrl;

  final List<String> _categories = [
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
  ];

  final List<String> _priorities = ['Low', 'Medium', 'High'];
  final List<String> _responsibles = [
    'Electrician',
    'Plumber',
    'Agent',
    'None',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.complaint.address);
    _descriptionController = TextEditingController(text: widget.complaint.description);
    _category = _categories.contains(widget.complaint.category) ? widget.complaint.category : null;
    _priority = _priorities.contains(widget.complaint.priority) ? widget.complaint.priority : null;
    _responsible = _responsibles.contains(widget.complaint.responsible) ? widget.complaint.responsible : null;
    _attachmentUrl = widget.complaint.attachmentUrl;
  }

  @override
  void dispose() {
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateComplaint() {
    if (_formKey.currentState!.validate()) {
      final updatedComplaint = Complaint(
        id: widget.complaint.id, // Keep the same ID for the updated complaint
        address: _addressController.text,
        description: _descriptionController.text,
        category: _category ?? '',
        priority: _priority ?? '',
        responsible: _responsible ?? 'None', // Add the responsible field
        attachmentUrl: _attachmentUrl,
        status: 'Opened', // Automatically set the status to Opened
      );

      _complaintController.updateComplaint(updatedComplaint);
      Get.back(); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: 'update_complaint'.tr, clr: AppTheme.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Complaint Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the complaint description';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(labelText: 'Complaint Category'),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _priority,
                decoration: InputDecoration(labelText: 'Priority'),
                items: _priorities.map((priority) {
                  return DropdownMenuItem<String>(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a priority';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _responsible,
                decoration: InputDecoration(labelText: 'Responsible'),
                items: _responsibles.map((responsible) {
                  return DropdownMenuItem<String>(
                    value: responsible,
                    child: Text(responsible),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _responsible = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a responsible person';
                  }
                  return null;
                },
              ),
              // You can add a file picker here to update the attachment if needed
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateComplaint,
                child: Text('Update Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
