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
        id: 1,
        roleId: 1,
        username: 'user1',
        password: 'password1',
        email: 'user1@example.com',
        image: 'default.png',
        about: 'About User 1',
        lastname: 'Family 1',
        dateOfBirth: '2000-01-01',
        position: 'Position 1',
        salary: '1000',
        startDate: '2024-01-01',
        phone: '1234567890',
        address: 'Address 1',
        createdAt: '2024-06-23',
        updatedAt: '2024-06-23',
        imageUrl: 'http://homease.tech/storage/users/default.png',
      ),
      User(
        id: 2,
        roleId: 2,
        username: 'user2',
        password: 'password2',
        email: 'user2@example.com',
        image: 'default.png',
        about: 'About User 2',
        lastname: 'Family 2',
        dateOfBirth: '2000-02-02',
        position: 'Position 2',
        salary: '2000',
        startDate: '2024-02-02',
        phone: '2345678901',
        address: 'Address 2',
        createdAt: '2024-06-23',
        updatedAt: '2024-06-23',
        imageUrl: 'http://homease.tech/storage/users/default.png',
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
