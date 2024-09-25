import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatAI extends StatelessWidget {
  const ChatAI({
    super.key,
    required this.message,
  });
  final Map<String, dynamic> message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          child: Image.asset('assets/images/robot-assistant.png'),
        ),
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
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: message['message'] == 'loading'
                ? Container(
                    width: 30,
                    height: 20,
                    child: const SpinKitThreeBounce(
                      color: Color(0xff000E08),
                      size: 20.0,
                    ),
                  )
                : Text(
                    message['message'],
                    maxLines: null,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000E08),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
