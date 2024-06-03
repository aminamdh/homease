// lib/core/controllers/chat_controller.dart

import 'package:get/get.dart';
import 'package:homease/core/models/message_model.dart';
import 'package:homease/core/models/user_model.dart';

class ChatController extends GetxController {
  var messages = <Message>[].obs;
  var newMessage = ''.obs;
  var users = <User>[].obs;
  var selectedUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    // Mock data for users
    users.value = [
      User(
        username: 'user1',
        password: 'password1',
        name: 'User 1',
        familyName: 'Family 1',
        wilaya: 'Wilaya 1',
        residenceName: 'Residence 1',
        blocNumber: 'Bloc 1',
        houseNumber: 'House 1',
        phoneNumber: 'Phone 1',
      ),
      User(
        username: 'user2',
        password: 'password2',
        name: 'User 2',
        familyName: 'Family 2',
        wilaya: 'Wilaya 2',
        residenceName: 'Residence 2',
        blocNumber: 'Bloc 2',
        houseNumber: 'House 2',
        phoneNumber: 'Phone 2',
      ),
      // Add more users as needed
    ];
  }

  void sendMessage(String sender) {
    if (newMessage.value.trim().isNotEmpty && selectedUser.value != null) {
      messages.add(
        Message(
          sender: sender,
          content: newMessage.value.trim(),
          timestamp: DateTime.now(),
        ),
      );
      newMessage.value = '';
    }
  }

  void selectUser(User user) {
    selectedUser.value = user;
    messages.clear();
    // Load messages for the selected user (mock data)
    messages.addAll([
      Message(sender: user.username, content: 'Hello', timestamp: DateTime.now()),
      Message(sender: 'user1', content: 'Hi', timestamp: DateTime.now()),
    ]);
  }
}
