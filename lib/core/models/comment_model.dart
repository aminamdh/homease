class Complaint {
  String userName;
  String blocNumber;
  String complaintName;
  String complaintState;
  String complaintDescription;
  String responsible;
  String? attachedImage;
  String status;

  Complaint({
    required this.userName,
    required this.blocNumber,
    required this.complaintName,
    required this.complaintState,
    required this.complaintDescription,
    required this.responsible,
    this.attachedImage,
    this.status = 'open',
  });

  factory Complaint.fromMap(Map<String, dynamic> map) {
    return Complaint(
      userName: map['user_id'].toString(), // Assuming user_id is used as userName
      blocNumber: map['address'],
      complaintName: map['title'],
      complaintState: map['category'],
      complaintDescription: map['description'],
      responsible: map['priority'],
      status: map['status'],
    );
  }
}
