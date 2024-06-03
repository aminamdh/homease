// lib/views/pages/messages.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/chat_controller.dart';
import 'package:homease/core/models/user_model.dart';
import 'package:homease/views/widgets/text.dart';

class MessagesPage extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final String currentUser = "user1"; // Replace with the actual current user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Header2(txt: 'Messages',clr: AppTheme.primaryColor,),
       
      ),
      body: Obx(() {
        if (chatController.selectedUser.value == null) {
          return UserList(chatController: chatController);
        } else {
          return ChatScreen(
            chatController: chatController,
            currentUser: currentUser,
          );
        }
      }),
    );
  }
}

class UserList extends StatelessWidget {
  final ChatController chatController;

  UserList({required this.chatController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatController.users.length,
      itemBuilder: (context, index) {
        final user = chatController.users[index];
        return ListTile(
          title: Text(user.name),
          subtitle: Text(user.username),
          onTap: () {
            chatController.selectUser(user);
          },
        );
      },
    );
  }
}

class ChatScreen extends StatelessWidget {
  final ChatController chatController;
  final String currentUser;

  ChatScreen({required this.chatController, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            return ListView.builder(
              itemCount: chatController.messages.length,
              itemBuilder: (context, index) {
                final message = chatController.messages[index];
                return Align(
                  alignment: message.sender == currentUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(vertical: 2.0),
                    decoration: BoxDecoration(
                      color: message.sender == currentUser
                          ? AppTheme.primaryColor
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: message.sender == currentUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.content,
                          style: TextStyle(
                            color: message.sender == currentUser
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          message.timestamp.toLocal().toString(),
                          style: TextStyle(
                            color: message.sender == currentUser
                                ? Colors.white70
                                : Colors.black54,
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) =>
                      chatController.newMessage.value = value,
                  controller: TextEditingController(
                      text: chatController.newMessage.value),
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () => chatController.sendMessage(currentUser),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
