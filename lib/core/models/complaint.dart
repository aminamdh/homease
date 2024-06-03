// models/complaint.dart
//import 'package:flutter/material.dart';

class Complaint {
  final String userName;
  final String blocNumber;
  final String complaintName;
  final String complaintState;
  final String complaintDescription;
  final String responsible;
  final String? attachedImage;
  final String? status;

  Complaint({
    required this.userName,
    required this.blocNumber,
    required this.complaintName,
    required this.complaintState,
    required this.complaintDescription,
    required this.responsible,
    this.attachedImage,
    this.status,
  });
}
