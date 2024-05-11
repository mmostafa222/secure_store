import 'package:flutter/material.dart';

import '../../model/chat_mesage.dart';

class MessageImage extends StatelessWidget {
  const MessageImage({required this.index, super.key, this.image});
  final ChatMessage? image;
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:100,
      child: image!=null?
      ClipRRect(
        child: Image.network(
          image!.imageUrl!,
          fit: BoxFit.fitWidth,
          errorBuilder: (context,object,t){
            return Icon(Icons.image);
          },
        ),
      ):Icon(Icons.image),
    );
  }
}
