import 'dart:io';
import 'package:get/get.dart';
import 'package:homease/core/models/complaint.dart';
import 'package:homease/core/services/api_service.dart';
import 'package:homease/core/services/getStorage.dart';
import 'package:logger/logger.dart';

class ComplaintController extends GetxController {
  var complaints = <Complaint>[].obs;
  final ApiService apiService = ApiService();
  final Logger logger = Logger();

  Future<void> addComplaint(Complaint complaint) async {
    String? token = gsService.getToken();
    const String createComplaintUrl = 'http://homease.tech/api/tickets';

    if (token != null) {
      try {
        await apiService.createComplaint(
          address: complaint.address,
          description: complaint.description,
          status: complaint.status,
          priority: complaint.priority,
          category: complaint.category,
          image: complaint.attachmentUrl != null ? File(complaint.attachmentUrl!) : null,
          token: token,
         
        );
        complaints.add(complaint);
        Get.snackbar("Success", "Complaint created successfully");
      } catch (e,s) {
        Get.snackbar("Error", "Failed to create complaint: ${e.toString()}");
        logger.e("Error creating complaint: $e: $s");
      }
    } else {
      Get.snackbar("Error", "Token not found");
      logger.e("Error: Token not found");
    }
  }

  Future<void> fetchComplaints() async {
    try {
      List<Complaint> fetchedComplaints = await apiService.getComplaints();
      complaints.assignAll(fetchedComplaints);
    } catch (e) {
      Get.snackbar("Error", "Failed to load complaints: ${e.toString()}");
      logger.e("Error loading complaints: $e");
    }
  }

  Future<void> updateComplaintStatus(int index, String status) async {
    logger.i("Updating status of complaint at index $index to $status");
    if (index < complaints.length) {
      var oldComplaint = complaints[index];
      var updatedComplaint = oldComplaint.copyWith(status: status);

      try {
        await apiService.updateComplaint(updatedComplaint);
        complaints[index] = updatedComplaint;
        complaints.refresh();
        Get.snackbar("Success", "Complaint status updated successfully");
      } catch (e) {
        Get.snackbar("Error", "Failed to update complaint status: ${e.toString()}");
        logger.e("Error updating complaint status: $e");
      }
    } else {
      logger.e("Error: Index $index is out of bounds for complaints list");
    }
  }

  Future<void> updateComplaint(Complaint complaint) async {
    try {
      await apiService.updateComplaint(complaint);
      int index = complaints.indexWhere((c) => c.id == complaint.id);
      if (index != -1) {
        complaints[index] = complaint;
        complaints.refresh();
        Get.snackbar("Success", "Complaint updated successfully");
      } else {
        Get.snackbar("Error", "Complaint not found");
        logger.e("Error: Complaint not found");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update complaint: ${e.toString()}");
      logger.e("Error updating complaint: $e");
    }
  }

  void deleteComplaint(int index) {
    complaints.removeAt(index);
  }
}
