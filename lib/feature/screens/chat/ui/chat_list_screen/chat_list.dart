import 'package:flutter/material.dart';
import 'package:secure_store/core/utils/AppColors.dart';

import 'chats_body.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const ChatsBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(backgroundColor: Color.fromARGB(255, 255, 152, 7),
      centerTitle: true,
      title: const Text(
        'Chats',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    
    );
  }

  
}
