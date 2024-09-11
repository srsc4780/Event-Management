import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.height,
      this.textAlign,
      this.maxLine});

  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? height;
  final int? maxLine;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      maxLines: maxLine,
      textAlign: textAlign,
      style: GoogleFonts.manrope(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height),
    );
  }
}
