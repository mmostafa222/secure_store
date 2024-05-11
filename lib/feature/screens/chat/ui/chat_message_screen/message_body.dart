import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/chat_mesage.dart';
import 'chat_input_field.dart';
import 'message.dart';

class MessageBody extends StatefulWidget {
  const MessageBody(
      {super.key, required this.reciverID, required this.reciverEmail});
  final String reciverID;
  final String reciverEmail;

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  Future<void> loadCertificate() async {
    try {
      ByteData data = await rootBundle.load('assets/certificate.crt');
      SecurityContext securityContext = SecurityContext.defaultContext;
      securityContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

      Fluttertoast.showToast(
          msg: "Your chat is Secured",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0);
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
      super.initState();
      Future.delayed(Duration.zero,(){
        loadCertificate();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<QuerySnapshot<Map>>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.size <= 0) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final snapShotData = snapshot.data;
                  final snapShotDataSize = snapShotData!.size;
                  List<ChatMessage> chatMessages = [];
                  final User = FirebaseAuth.instance.currentUser!;

                  for (var element in snapshot.data!.docs) {
                    final data = element.data();
                    ChatMessageType type;
                    ChatMessage message;
                    final senderId = data['sender'];
                    if (data['image'] != null) {
                      type = ChatMessageType.image;
                      message = ChatMessage(
                        messageType: type,
                        messageStatus: MessageStatus.viewed,
                        isSender: User.displayName == data['sender'],
                        senderImage: data['sender'],
                        sender: data['sender'],
                        imageUrl: data['image'] ?? '',
                      );
                    } else {
                      type = ChatMessageType.text;
                      message = ChatMessage(
                        messageType: type,
                        messageStatus: MessageStatus.viewed,
                        isSender: User.displayName == data['sender'],
                        senderImage: data['sender'],
                        sender: data['sender'],
                        text: data['message'],
                      );
                    }
                    if ((data['sender'] == User.displayName ||
                            data['reciver'] == User.displayName) &&
                        (data['sender'] == widget.reciverID ||
                            data['reciver'] == widget.reciverID)) {
                      chatMessages.add(message);
                    }
                  }
                  return ListView.builder(
                      itemCount: chatMessages.length,
                      itemBuilder: (context, index) => Message(
                            message: chatMessages[index],
                            index: index,
                            image: chatMessages[index],
                          ));
                },
              )),
        ),
        ChatInputField(reciverID: widget.reciverID),
      ],
    );
  }
}
