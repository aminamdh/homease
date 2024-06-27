import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/reminder_controller.dart';
import 'package:homease/views/widgets/text.dart';

class ReminderPage extends StatelessWidget {
  final ReminderController reminderController = Get.put(ReminderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: 'reminders'.tr, clr: AppTheme.primaryColor),
        // backgroundColor: AppTheme.primaryColor,
      ),
      body: Column(
        children: [
          // Faded line between AppBar and body
          Container(
            height: 1.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.0),
                  AppTheme.primaryColor.withOpacity(0.5),
                  AppTheme.primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (reminderController.reminders.isEmpty) {
                return Center(child: Text('no_reminders_available'.tr));
              } else {
                return ListView.builder(
                  itemCount: reminderController.reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = reminderController.reminders[index];
                    return ListTile(
                      leading: Icon(Icons.notifications_active, color: AppTheme.primaryColor),
                      title: Text(reminder.title),
                      subtitle: Text(reminder.description),
                      trailing: Text(
                        '${reminder.dueDate.day}/${reminder.dueDate.month}/${reminder.dueDate.year}',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        // Action on tap (if any)
                      },
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
