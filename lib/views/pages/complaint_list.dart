import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/complaint_controller.dart';
import 'package:homease/views/pages/complaints.dart';
import 'dart:io';

import 'package:homease/views/widgets/text.dart';

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
          Container(
            height: 2.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.7),
                  AppTheme.primaryColor.withOpacity(0.0),
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

class ComplaintListPage extends StatelessWidget {
  final ComplaintController _complaintController = Get.put(ComplaintController());

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
                    leading: complaint.attachedImage != null
                        ? Image.file(File(complaint.attachedImage!), width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.image_not_supported),
                    title: Text(complaint.complaintName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(complaint.complaintDescription),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () {
                                _complaintController.updateComplaintStatus(index, "Fixed");
                              },
                              child: Header4(txt: 'fixed'.tr, clr: AppTheme.primaryColor),
                            ),
                            TextButton(
                              onPressed: () {
                                _complaintController.updateComplaintStatus(index, "Not Fixed");
                              },
                              child: Header4(txt: 'not_fixed'.tr, clr: AppTheme.primaryColor),
                            ),
                          ],
                        ),
                        Text("status".tr + ": ${complaint.status}"),
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
}
