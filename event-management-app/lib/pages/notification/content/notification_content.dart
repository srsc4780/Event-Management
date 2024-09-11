import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/porvider/notification_provider.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/utils.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';

class NotificationContent extends StatelessWidget {
  final NotificationProvider? provider;

  const NotificationContent({
    super.key, this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.notificationResponse?.data?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final data = provider.notificationResponse?.data?.data?[index];
                    printDebug(data!.createdAt.toString());
    
                    // Parse and format the createdAt date if not null
                    String formattedDate = '';
                    if (data.createdAt != null) {
                      DateTime dateTime = DateTime.parse(data.createdAt.toString());
                      formattedDate = DateFormat('dd MMM, h:mm a').format(dateTime);
                    }
    
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h), // Adds vertical spacing between items
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/image/Notification_img.png',
                            height: 48.h,
                            width: 48.w,
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: data.title ?? '',
                                  fontSize: 14.r,
                                  color: black,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(height: 4.h),
                                CustomText(
                                  text: data.description ?? '',
                                  fontSize: 12.r,
                                  color: bodyTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(height: 4.h), // Adds spacing between description and date
                                if (formattedDate.isNotEmpty)
                                  CustomText(
                                    text: formattedDate,
                                    fontSize: 12.r,
                                    color: bodyTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
