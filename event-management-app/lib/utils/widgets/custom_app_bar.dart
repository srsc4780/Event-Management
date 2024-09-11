import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final String? appBarName;
  final Function()? onTap;
  final bool? isBackButton;
  const CustomAppBar(
      {super.key, this.appBarName, this.onTap, this.isBackButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: AppBar(
        centerTitle: true,
        leading: Visibility(
          visible: isBackButton ?? true,
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 8, bottom: 8),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/icon/back_icon.png',
              ),
            ),
          ),
        ),
        leadingWidth: 65,
        automaticallyImplyLeading: false,
        backgroundColor: white,
        elevation: 0,
        title: Text(
          '$appBarName',
          // 'Forget Password',
          style: GoogleFonts.manrope(
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
