import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sales_tracker/pages/auth_pages/forget_password/content/new_password_page.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_app_bar.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: const CustomAppBar(appBarName: 'Verify OTP'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Authentication Code",
                style: GoogleFonts.manrope(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                'Enter 4-digit code we just texted to your\nPhone number: +880 *** **** 36',
                style: TextStyle(
                    height: 1.6,
                    color: bodyTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 26.h,
              ),
              ////Email/phone from field////
              Center(
                child: OTPTextField(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                    // controller: otpController,
                    otpFieldStyle: OtpFieldStyle(
                      enabledBorderColor: borderColor.withOpacity(0.5),
                      focusBorderColor: primarySolidColor.withOpacity(0.2),
                      backgroundColor: Colors.white,
                    ),
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceBetween,
                    fieldWidth: 60.w,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15.r,
                    style: TextStyle(fontSize: 25.sp),
                    onChanged: (pin) {
                      // ignore: avoid_print
                      print("Changed: $pin");
                    },
                    onCompleted: (pin) {
                      // ignore: avoid_print
                      print("Completed: $pin");
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                  elevation: 5,
                ),
                onPressed: () {
                  NavUtil.navigateScreen(context, const NewPasswordPage());
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color(0xffFF5A70),
                        Color(0xffB50820),
                        Color(0xffFF5A70)
                      ], tileMode: TileMode.decal),
                      borderRadius: BorderRadius.circular(4)),
                  child: const SizedBox(
                      height: 45,
                      width: 120,
                      // constraints: const BoxConstraints(minWidth: 88.0),
                      child: Center(
                        child: Text('VERIFY NOW',
                            style: TextStyle(color: white),
                            textAlign: TextAlign.center),
                      )),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Resend code',
                style: TextStyle(
                    color: primarySolidColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
