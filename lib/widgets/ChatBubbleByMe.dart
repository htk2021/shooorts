import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  ChatBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/speechbubble2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
