import 'dart:ui';
import 'package:chat_app/helpers/spacing.dart';
import 'package:chat_app/themes/colors.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:chat_app/widgets/app_text_button.dart';
import 'package:chat_app/widgets/onboarding_ovalpainter.dart';
import 'package:chat_app/widgets/positioned_signin_text.dart';
import 'package:chat_app/widgets/row_social_icons.dart';
import 'package:chat_app/widgets/textSpan_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static String id = 'onboarding_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainBlack,
      body: Stack(
        children: [
          // Use BackdropFilter for the blur effect
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: ColorsManager.lightBlack,
              ),
              child: CustomPaint(
                painter: OvalPainter(),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: Text(
                    'Connect friends\neasily & quickly',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 78, // Adjust font size
                      fontWeight: FontWeight.w500,
                      height: 1.2.h, // Adjust line height
                      letterSpacing: 1.5.w, // Adjust letter spacing
                    ),
                  ),
                ),
                verticalSpace(20),
                Text(
                  'Our chat app is the perfect way to stay \nconnected with friends and family.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    letterSpacing: 2.2.w,
                  ),
                ),
                verticalSpace(40),
                const RowSocialIcons(
                  imageIcon1: 'assets/images/facebook.png',
                  imageIcon2: 'assets/images/google.png',
                  imageIcon3: 'assets/images/apple.png',
                ),
                verticalSpace(20),
                const RowTextDivider(
                  textColor: Colors.white70,
                ),
                verticalSpace(30),
                AppTextButton(
                  buttonText: 'Sign up withn mail',
                  textStyle: TextStyle(
                    color: const Color(0xff000E08),
                    fontSize: 16.sp,
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.id);
                  },
                ),
                const Spacer(),
                const TextSpanSignin(),
                verticalSpace(20),
              ],
            ),
          ),
          const PositionedSigninText(),
        ],
      ),
    );
  }
}

class RowTextDivider extends StatelessWidget {
  const RowTextDivider({
    super.key,
    required this.textColor,
  });

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: ColorsManager.offWhite,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: TextStyle(color: textColor),
          ),
        ),
        const Expanded(
          child: Divider(
            color: ColorsManager.offWhite,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
