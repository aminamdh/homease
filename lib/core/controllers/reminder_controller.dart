import 'package:get/get.dart';
import 'package:homease/core/models/reminder_model.dart';
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
    // For now, i will use some mock data
    var mockReminders = [
      Reminder(title: 'Electricity Bill', description: 'Due on 1st June', dueDate: DateTime(2024, 6, 1)),
      Reminder(title: 'Water Bill', description: 'Due on 5th June', dueDate: DateTime(2024, 6, 5)),
      Reminder(title: 'Rent Bill', description: 'Due on 10th June', dueDate: DateTime(2024, 6, 10)),
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
