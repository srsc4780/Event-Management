import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/porvider/notification_provider.dart';
import 'package:sales_tracker/pages/notification/content/notification_content.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_app_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CustomAppBar(appBarName: 'Notification'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => NotificationProvider(context),
        child: Consumer<NotificationProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // if (provider.errorMessage != null) {
            //   return Center(child: Text(provider.errorMessage!));
            // }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: NotificationContent(provider: provider),
            );
          },
        ),
      ),
    );
  }
}
