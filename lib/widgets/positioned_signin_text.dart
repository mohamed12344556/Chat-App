import 'package:chat_app/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PositionedSigninText extends StatelessWidget {
  const PositionedSigninText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 149,
      left: 149,
      height: 61,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 20.h,
            width: 16.w,
          ),
          horizontalSpace(6),
          Text(
            "ChatBox",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}