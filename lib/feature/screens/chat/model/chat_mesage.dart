import 'package:flutter/material.dart';

enum ChatMessageType { text, audio, image, video }

enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final String? sender;
  final String? senderImage;
  final String? imageUrl;

  ChatMessage(
      {this.text = '',
      required this.messageType,
      required this.messageStatus,
      required this.isSender,
      this.sender,
      this.senderImage,
      this.imageUrl});

  get imagepath => null;
}

class ChatMessages with ChangeNotifier {
  List<ChatMessage> chatMessages = [
    ChatMessage(
        text: 'hi eslam ,how are you',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: true),
    ChatMessage(
        text: 'hope you are doing well',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: true),
    ChatMessage(
        text: 'iam good ',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false),
    ChatMessage(
        text: 'happy to here that',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: true),
    ChatMessage(
        text: 'hi eslam ,how are you',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: true),
    ChatMessage(
        text: 'thanks',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false),
    ChatMessage(
        text: 'hi eslam ,how are you',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: true),
    ChatMessage(
        text: 'hi eslam ,how are you',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: true),
  ];
  void addMessage(ChatMessage message) {
    chatMessages.add(message);
    notifyListeners();
  }

  List<ChatMessage> get getMessageList => chatMessages;
}
