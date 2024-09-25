import 'package:chat_app/themes/colors.dart';
import 'package:chat_app/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  final Function(String) onChanged;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 18.h),
        focusedBorder: focusedBorder ??
            const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffCDD1D0),
                width: 1.3,
              ),
            ),
        enabledBorder: enabledBorder ??
            const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffCDD1D0),
                width: 1.3,
              ),
            ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffFF2D1B),
            width: 1.3,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffFF2D1B),
            width: 1.3,
          ),
        ),
        label: Text(
          hintText,
          style: hintStyle ?? TextStyles.font14DarkBlueMedium,
        ),
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? const Color.fromARGB(255, 255, 255, 255),
        filled: false,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyles.font14DarkBlueMedium,
      validator: (value) {
        return validator(value);
      },
      onChanged: onChanged,
    );
  }
}
