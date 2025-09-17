import 'package:flutter/material.dart';
import 'package:scholer_chat_app/models/massages_model.dart';

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    super.key, required this.message,
  });

  final MassagesModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
        decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),)
        ),
        child:  Text(
          message.massage,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}