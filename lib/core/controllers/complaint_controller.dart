import 'package:get/get.dart';
import 'package:homease/core/models/complaint.dart';

class ComplaintController extends GetxController {
  final RxList<Complaint> _complaints = <Complaint>[].obs;

  List<Complaint> get complaints => _complaints;

  void addComplaint(Complaint complaint) {
    _complaints.add(complaint);
  }

  void updateComplaintStatus(int index, String status) {
    _complaints[index] = _complaints[index].copyWith(status: status);
  }
}

extension ComplaintCopyWith on Complaint {
  Complaint copyWith({
    String? userName,
    String? blocNumber,
    String? complaintName,
    String? complaintState,
    String? complaintDescription,
    String? responsible,
    String? attachedImage,
    String? status,
  }) {
    return Complaint(
      userName: userName ?? this.userName,
      blocNumber: blocNumber ?? this.blocNumber,
      complaintName: complaintName ?? this.complaintName,
      complaintState: complaintState ?? this.complaintState,
      complaintDescription: complaintDescription ?? this.complaintDescription,
      responsible: responsible ?? this.responsible,
      attachedImage: attachedImage ?? this.attachedImage,
      status: status ?? this.status,
    );
  }
}
