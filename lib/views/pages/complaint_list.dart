import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/complaint_controller.dart';
import 'package:homease/core/models/complaint.dart';
import 'package:homease/views/pages/complaints.dart';
import 'package:homease/views/pages/update_complaint.dart';
import 'package:homease/views/widgets/text.dart';

class ComplaintListPage extends StatelessWidget {
  final ComplaintController _complaintController = Get.put(ComplaintController());

  ComplaintListPage() {
    _complaintController.fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: 'complaint_list'.tr, clr: AppTheme.primaryColor),
      ),
      body: Column(
        children: [
          Container(
            height: 4.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.4),
                  AppTheme.primaryColor.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: _complaintController.complaints.length,
                itemBuilder: (context, index) {
                  final complaint = _complaintController.complaints[index];
                  return ListTile(
                    leading: complaint.attachmentUrl != null
                        ? Image.network(
                            complaint.attachmentUrl!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error);
                            },
                          )
                        : Icon(Icons.image_not_supported),
                    title: Text(complaint.address),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(complaint.description),
                        Text("Category: ${complaint.category}"),
                        Text("Priority: ${complaint.priority}"),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () {
                                _complaintController.updateComplaintStatus(index, "Validated");
                              },
                              child: Header4(txt: 'validate'.tr, clr: AppTheme.primaryColor),
                            ),
                            TextButton(
                              onPressed: () {
                                _navigateToUpdatePage(complaint);
                              },
                              child: Header4(txt: 'update'.tr, clr: AppTheme.primaryColor),
                            ),
                            TextButton(
                              onPressed: () {
                                _complaintController.deleteComplaint(index);
                              },
                              child: Header4(txt: 'delete'.tr, clr: AppTheme.primaryColor),
                            ),
                          ],
                        ),
                        Text("Status: ${complaint.status}"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToUpdatePage(Complaint complaint) {
    Get.to(() => UpdateComplaintPage(complaint: complaint));
  }
}
