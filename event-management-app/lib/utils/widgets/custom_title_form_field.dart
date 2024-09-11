import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart'; // For TextInputFormatter
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';

class CustomTitleFromField extends StatelessWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final Icon? suffixIcon;
  final Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType; // Optional parameter for keyboard type
  final bool isPassword; // Optional parameter for password field
  final String? errorText; // Optional errorText

  const CustomTitleFromField({
    Key? key,
    this.hintText,
    this.title,
    this.controller,
    this.suffixIcon,
    this.onChange,
    this.inputFormatters = const [],
    this.validator,
    this.keyboardType,
    this.isPassword = false, // Default to false
    this.errorText, // Optional errorText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8.h,
        ),
        if (title != null)
          CustomText(
            text: title!,
            color: Colors.black,
            fontSize: 14.r,
            fontWeight: FontWeight.w700,
          ),
        SizedBox(
          height: 8.h,
        ),
        TextFormField(
          onChanged: onChange,
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType ?? TextInputType.text, // Default to text
          obscureText: isPassword, // Handle password input
          decoration: InputDecoration(
            filled: true,
            fillColor: white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor.withOpacity(0.5), width: 1.0),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
            hintText: hintText,
            errorText: errorText, // Handle errorText
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: bodyTextColor.withOpacity(0.3)),
            ),
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(
              fontSize: 14.r,
              color: bodyTextColor,
              fontWeight: FontWeight.w400,
            ),
            border: const OutlineInputBorder(),
          ),
          validator: validator ?? 
              (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required.';
                }
                return null;
              },
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}
