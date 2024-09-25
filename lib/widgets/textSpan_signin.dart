import 'package:chat_app/views/register_screen.dart';
import 'package:flutter/material.dart';

class TextSpanSignin extends StatelessWidget {
  const TextSpanSignin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Text.rich(
        TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(color: Colors.white70),
          children: [
            TextSpan(
              text: 'Sign in',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          (context),
          RegisterScreen.id,
        );
      },
    );
  }
}
