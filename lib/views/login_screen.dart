import 'dart:developer';

import 'package:chat_app/helpers/spacing.dart';
import 'package:chat_app/themes/font_weight_helper.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/home_screen.dart';
import 'package:chat_app/views/onboarding_screen.dart';
import 'package:chat_app/widgets/app_text_button.dart';
import 'package:chat_app/widgets/app_text_form_field.dart';
import 'package:chat_app/widgets/row_social_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isInputValid = false;

  void validateInput() {
    if (formkey.currentState!.validate()) {
      setState(() {
        isInputValid = true;
      });
    } else {
      setState(() {
        isInputValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Color(0xff000E08),
            size: 20,
          ),
        ),
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 3,
                          child: Container(
                            width: 56,
                            height: 8,
                            color: const Color(0xff58C3B6).withOpacity(1),
                          ),
                        ),
                        const Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      ' to Chat Box',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                verticalSpace(16),
                const Text(
                  'Welcome back! Sign in using your social media account or email to continue us',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff797C7B),
                    fontSize: 14,
                  ),
                ),
                verticalSpace(30),
                const RowSocialIcons(
                  imageIcon1: 'assets/images/facebook2.png',
                  imageIcon2: 'assets/images/google2.png',
                  imageIcon3: 'assets/images/apple2.png',
                ),
                verticalSpace(30),
                const RowTextDivider(
                  textColor: Color(0xff797C7B),
                ),
                verticalSpace(30),
                AppTextFormField(
                  controller: email,
                  hintText: 'Your email',
                  hintStyle: const TextStyle(
                    color: Color(0xff24786D),
                  ),
                  backgroundColor: const Color(0xffCDD1D0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    validateInput();
                    email.text = value;
                  },
                ),
                verticalSpace(30),
                AppTextFormField(
                  controller: password,
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    color: Color(0xff24786D),
                  ),
                  backgroundColor: const Color(0xffCDD1D0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  isObscureText: true,
                  onChanged: (value) {
                    validateInput();
                    password.text = value;
                  },
                ),
                verticalSpace(172),
                AppTextButton(
                  buttonText: 'Log in',
                  backgroundColor: isInputValid == true
                      ? const Color(0xff24786D)
                      : const Color(0xffF3F6F6),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        log(credential.user!.displayName.toString());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }

                      Navigator.pushNamed(
                        context,
                        HomeScreen.id,
                        arguments: email.text,
                      );
                    }
                  },
                  buttonHeight: 50,
                  textStyle: TextStyle(
                    color: isInputValid == true
                        ? Colors.white
                        : const Color(0xff797C7B),
                  ),
                ),
                verticalSpace(16),
                const Text(
                  'Forget password ?',
                  style: TextStyle(
                    color: Color(0xff24786D),
                    fontSize: 14,
                    fontWeight: FontWeightHelper.medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
