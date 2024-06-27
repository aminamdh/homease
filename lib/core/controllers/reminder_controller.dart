import 'package:get/get.dart';
import 'package:homease/core/models/reminder_model.dart';

class ReminderController extends GetxController {
  var reminders = <Reminder>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReminders();
  }

  void fetchReminders() {
    // This should be replaced with actual data fetching logic
    // For now, I will use some mock data
    var mockReminders = [
      Reminder(title: 'electricity_bill'.tr, description: 'due_on_1st_june'.tr, dueDate: DateTime(2024, 6, 1)),
      Reminder(title: 'water_bill'.tr, description: 'due_on_5th_june'.tr, dueDate: DateTime(2024, 6, 5)),
      Reminder(title: 'rent_bill'.tr, description: 'due_on_10th_june'.tr, dueDate: DateTime(2024, 6, 10)),
    ];
    reminders.addAll(mockReminders);
  }

  void addReminder(Reminder reminder) {
    reminders.add(reminder);
  }

  void removeReminder(Reminder reminder) {
    reminders.remove(reminder);
  }
}
