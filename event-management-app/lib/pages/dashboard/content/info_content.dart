import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/local/local_auth_provider.dart';
import 'package:sales_tracker/pages/bottom_nav_bar/custom_bottom_nav.dart';
import 'package:sales_tracker/pages/notification/view/notification_page.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';

class InfoContent extends StatelessWidget {
  const InfoContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalAutProvider>(context);
    final user = provider.getUser();
    return InkWell(
      onTap: () {
         NavUtil.navigateScreen(
            context, const CustomBottomNavBar(bottomNavigationIndex: 4));
      },
      child: Row(
        children: [
          Image.asset(
            'assets/image/User_image.png',
            height: 40.h,
            width: 40.w,
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: user?.name,
                fontSize: 16.r,
                fontWeight: FontWeight.w600,
              ),
              // CustomText(
              //   text: '623/1, Vadra Lane, Maghbazar',
              //   fontSize: 14.r,
              //   color: bodyTextColor,
              //   fontWeight: FontWeight.w600,
              // ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
