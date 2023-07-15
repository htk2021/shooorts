import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  ChatBubble(this.message, this.isMe);

  @override
  Widget build(BuildContext context) {
    final bubbleAlignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleImage = isMe ? 'images/test_me.png' : 'images/test_you.png';
    final bubblePadding = isMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30);
    final textAlign = isMe ? TextAlign.end : TextAlign.start;

    return Container(
      padding: bubblePadding,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      alignment: bubbleAlignment,
      constraints: BoxConstraints(
        minHeight: 100
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bubbleImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30,bottom: 30),
        child: Text(
          message,
          style: TextStyle(color: Colors.black, ),
          textAlign: textAlign,
        ),
      )
    );
  }
}
