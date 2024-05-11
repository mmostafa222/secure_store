import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_store/core/utils/AppColors.dart';
import 'package:secure_store/core/utils/textstyle.dart';

import '../../model/chats.dart';
import '../chat_message_screen/chat_message_screen.dart';
import '../chat_message_screen/message_body.dart'; // Assuming you have a model for chats

class ChatsBody extends StatefulWidget {
  const ChatsBody({Key? key});

  @override
  State<ChatsBody> createState() => _ChatsBodyState();
}

class _ChatsBodyState extends State<ChatsBody> {
  // Future<List<Chat>> fetchChats() async {
  //   final currentUserID = FirebaseAuth.instance.currentUser!.displayName;
  //   final chatsRef = FirebaseFirestore.instance.collection('messages');

  //   try {
  //     final querySnapshot =
  //         await chatsRef.where('reciver', isEqualTo: currentUserID).get();

  //     final senderQuerySnapshot =
  //         await chatsRef.where('sender', isEqualTo: currentUserID).get();

  //     querySnapshot.docs.addAll(senderQuerySnapshot.docs);

  //     final List<Chat> chats = querySnapshot.docs.map((doc) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       final isCurrentUserSender = data['sender'] == currentUserID;

  //       return Chat(
  //         name: isCurrentUserSender ? data['reciver'] : data['sender'],
  //         lastMessage: data['message'],
  //         time: (data['time'] as Timestamp).toDate().toString(),
  //         isActive: true,
  //         // Add other properties as needed
  //       );
  //     }).toList();

  //     return chats;
  //   } catch (e) {
  //     print('Error fetching chats: $e');
  //     return [];
  //   }
  // }
  Future<List<Chat>> fetchChats() async {
    final currentUserID = FirebaseAuth.instance.currentUser!.displayName;
    final chatsRef = FirebaseFirestore.instance.collection('messages');

    try {
      final querySnapshot =
          await chatsRef.where('sender', isEqualTo: currentUserID).get();
      final querySnapshot2 =
          await chatsRef.where('reciver', isEqualTo: currentUserID).get();

      final Set<String> uniqueChatNames = {};

      final List<Chat> chats = [];

      querySnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;

        final chatName = data['reciver'];

        if (!uniqueChatNames.contains(chatName)) {
          uniqueChatNames.add(chatName);

          chats.add(Chat(
            name: chatName,
            lastMessage: data['message'],
            time: (data['time'] as Timestamp).toDate().toString(),
            isActive: true,
            // Add other properties as needed
          ));
        }
      });

      querySnapshot2.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;

        final chatName = data['sender'];

        if (!uniqueChatNames.contains(chatName)) {
          uniqueChatNames.add(chatName);

          chats.add(Chat(
            name: chatName,
            lastMessage: data['message'],
            time: (data['time'] as Timestamp).toDate().toString(),
            isActive: true,
            // Add other properties as needed
          ));
        }
      });

      return chats;
    } catch (e) {
      print('Error fetching chats: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Chat>>(
        future: fetchChats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<Chat> chats = snapshot.data ?? [];
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  title: Text(
                    chat.name,
                    style: getTitleStyle(
                        color: appcolors.primerycolor, fontSize: 18),
                  ),
                  subtitle: Text(chat.lastMessage),
                  selectedTileColor: appcolors.primerycolor,
                  focusColor: Colors.amber,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChatMessageScreen(
                        reciverID: chat.name,
                        reciverName: chat.name,
                      );
                    }));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
