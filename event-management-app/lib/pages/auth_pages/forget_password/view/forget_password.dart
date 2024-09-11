import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_tracker/pages/auth_pages/forget_password/content/otp_page.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_app_bar.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';
import 'package:sales_tracker/utils/widgets/custom_title_form_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: const CustomAppBar(appBarName: 'Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: 'Reset Password',
                color: Colors.black,
                fontSize: 20.r,
                fontWeight: FontWeight.w400),
            CustomText(
                text:
                    'Select which contact details should we use to reset your password',
                color: bodyTextColor,
                fontSize: 12.r,
                fontWeight: FontWeight.w300),
            SizedBox(height: 20.h),
            const CustomTitleFromField(
              title: 'Phone',
              hintText: 'Enter your phone number',
            ),
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //       border: Border.all(color: borderColor.withOpacity(0.5)),
            //       borderRadius: BorderRadius.circular(8)),
            //   child: Row(
            //     children: [
            //       Image.asset(
            //         'assets/icon/sms_icon.png',
            //         height: 50.h,
            //         width: 50.w,
            //       ),
            //       SizedBox(width: 15.w),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           CustomText(
            //               text: 'via SMS',
            //               color: bodyTextColor,
            //               fontSize: 14.r,
            //               fontWeight: FontWeight.w400),
            //           SizedBox(height: 6.h),
            //           CustomText(
            //               text: '01738263403',
            //               color: black,
            //               fontSize: 14.r,
            //               fontWeight: FontWeight.w400),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0.0),
                elevation: 5,
              ),
              onPressed: () {
                NavUtil.navigateScreen(context, const OtpPage());
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
                      child: Text('CONTINUE',
                          style: TextStyle(color: white),
                          textAlign: TextAlign.center),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
