import 'dart:developer';

import 'package:chat_app/helpers/spacing.dart';
import 'package:chat_app/widgets/custom_icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RowSocialIcons extends StatefulWidget {
  const RowSocialIcons({
    super.key,
    required this.imageIcon1,
    required this.imageIcon2,
    required this.imageIcon3,
  });

  final String imageIcon1, imageIcon2, imageIcon3;

  @override
  State<RowSocialIcons> createState() => _RowSocialIconsState();
}

class _RowSocialIconsState extends State<RowSocialIcons> {
  

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          imageIcon: widget.imageIcon1,
          onPressed: () => log('Facebook button pressed'),
        ),
        horizontalSpace(20),
        CustomIconButton(
          onPressed: () {
            signInWithGoogle();
          },
          imageIcon: widget.imageIcon2,
        ),
        horizontalSpace(20),
        CustomIconButton(
          onPressed: () => log('Apple button pressed'),
          imageIcon: widget.imageIcon3,
        ),
      ],
    );
  }
}
