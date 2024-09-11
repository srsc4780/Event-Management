import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_tracker/data/porvider/dashboard_provider.dart';
import 'package:sales_tracker/utils/widgets/summary_title.dart';

class SummaryContent extends StatelessWidget {
  final DashboardProvider? provider;

  const SummaryContent({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    final data = provider?.dashboardResponse?.data;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Summary',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            // Display the data in summary tiles
            SummaryTile(
              title: 'Total Events',
              value: data?.totalEvents.toString() ?? '0',
            ),
            SizedBox(height: 10.h),
            SummaryTile(
              title: 'Upcoming Events',
              value: data?.upcomingEventsCount.toString() ?? '0',
            ),
            SizedBox(height: 10.h),
            SummaryTile(
              title: 'Left Events',
              value: data?.leftEventsCount.toString() ?? '0',
            ),
            SizedBox(height: 10.h),
            SummaryTile(
              title: 'Total Users',
              value: data?.totalUsers.toString() ?? '0',
            ),
          ],
        ),
      ),
    );
  }
}
