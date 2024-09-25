import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.imageIcon,
  });
  final String imageIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Image.asset(
          imageIcon,
          width: 48.w,
          height: 48.h,
        ),
        iconSize: 50,
        onPressed: onPressed);
  }
}