import 'package:flutter/material.dart';

class ChatUser extends StatelessWidget {
  const ChatUser({
    super.key,
    required this.message,
  });

  final Map<String, dynamic> message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(
              top: 35,
              left: 5,
              right: 16,
              bottom: 16,
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 221, 229, 235),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              message['message'],
              maxLines: null,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000E08)),
            ),
          ),
        ),
        CircleAvatar(
          child: Image.asset('assets/images/bmw.webp'),
        ),
      ],
    );
  }
}
