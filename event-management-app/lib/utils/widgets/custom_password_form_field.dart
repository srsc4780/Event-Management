import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';

class CustomPasswordFromField extends StatefulWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Optional validator
  final void Function(String)? onChanged; // Optional onChanged callback
  final String? errorText; // Optional errorText

  const CustomPasswordFromField({
    Key? key,
    this.hintText,
    this.title,
    this.controller,
    this.validator,
    this.onChanged,
    this.errorText, // Optional errorText to show validation issues
  }) : super(key: key);

  @override
  State<CustomPasswordFromField> createState() => _CustomPasswordFromFieldState();
}

class _CustomPasswordFromFieldState extends State<CustomPasswordFromField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          CustomText(
            text: widget.title!,
            color: Colors.black,
            fontSize: 14.r,
            fontWeight: FontWeight.w700,
          ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscure,
          onChanged: widget.onChanged,
          validator: widget.validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor.withOpacity(0.5), width: 1.0),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
            hintText: widget.hintText,
            errorText: widget.errorText, // Handle errorText if provided
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: bodyTextColor.withOpacity(0.3)),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility, // Adjust the icon toggle
                color: Colors.grey.withOpacity(.4),
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
            hintStyle: TextStyle(
              fontSize: 14.r,
              color: bodyTextColor,
              fontWeight: FontWeight.w400,
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
