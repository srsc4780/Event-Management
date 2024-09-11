import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/local/local_auth_provider.dart';
import 'package:sales_tracker/data/porvider/dashboard_provider.dart';
import 'package:sales_tracker/pages/auth_pages/login/view/login_page.dart';
import 'package:sales_tracker/pages/dashboard/content/info_content.dart';
import 'package:sales_tracker/pages/dashboard/content/summary_content.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final localAuthProvider = Provider.of<LocalAutProvider>(context);
    final user = localAuthProvider.getUser();

    if (user == null) {
      return const LoginPage();
    }

    return Scaffold(
      backgroundColor: white,
      body: ChangeNotifierProvider(
        create: (context) => DashboardProvider(context),
        child: Consumer<DashboardProvider>(builder: (context, provider, _) {
          return SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InfoContent(),
                  SizedBox(height: 24.h),
                  SummaryContent(provider: provider),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ));
        }),
      ),
    );
  }
}
