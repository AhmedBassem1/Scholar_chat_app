import 'package:flutter/material.dart';
import 'package:scholer_chat_app/models/massages_model.dart';
import 'package:scholer_chat_app/wighets/constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key, required this.message,
  });

  final MassagesModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),)
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