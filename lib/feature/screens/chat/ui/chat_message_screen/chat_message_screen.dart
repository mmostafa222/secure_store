import 'package:flutter/material.dart';
import 'package:secure_store/core/utils/AppColors.dart';

import 'message_body.dart';

class ChatMessageScreen extends StatefulWidget {
  const ChatMessageScreen(
      {super.key,
      required this.reciverID,
      required this.reciverName,});
  final String reciverID;
  final String reciverName;
  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: MessageBody(
        reciverID: widget.reciverName,
        reciverEmail: widget.reciverID,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: appcolors.primerycolor,
      title: Text(
        widget.reciverName,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
