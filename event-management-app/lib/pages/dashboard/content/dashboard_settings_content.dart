import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';

class DashboardSettingsContent extends StatelessWidget {
  const DashboardSettingsContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff4A43EC).withOpacity(0.1),
                      Colors.white
                    ])),
            child: Column(
              children: [
                CustomText(
                  text: 'Shop Setting',
                  fontSize: 14.r,
                  color: black,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: 'Manage Your Shop Information.',
                  fontSize: 12.r,
                  color: bodyTextColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.red,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: 'This features is not available yet!');
                    },
                    child: const Text(
                      'Setting',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      primarySolidColor.withOpacity(0.1),
                      Colors.white
                    ])),
            child: Column(
              children: [
                CustomText(
                  text: 'Payment Setting',
                  fontSize: 14.r,
                  color: black,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: 'Update your Payment Method.',
                  fontSize: 12.r,
                  color: bodyTextColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: 'This features is not available yet!');
                    },
                    child: const Text(
                      'Configure',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
