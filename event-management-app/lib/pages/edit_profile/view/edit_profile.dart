import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/local/local_auth_provider.dart';
import 'package:sales_tracker/data/porvider/profile_provider.dart';
import 'package:sales_tracker/pages/auth_pages/login/view/login_page.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_app_bar.dart';
import 'package:sales_tracker/utils/widgets/custom_password_form_field.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';
import 'package:sales_tracker/utils/widgets/custom_title_form_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localAuthProvider = Provider.of<LocalAutProvider>(context); // Corrected 'LocalAutProvider' to 'LocalAuthProvider'
    final user = localAuthProvider.getUser();

    if (user == null) {
      return const LoginPage();
    }

    return ChangeNotifierProvider(
      create: (context) => ProfileProvider()..setUser(user),
      child: Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.h),
          child: const CustomAppBar(appBarName: 'Edit Profile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/image/User_image.png'),
                  ),
                  Positioned(
                    right: -20,
                    bottom: 10,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.red),
                      onPressed: () {
                        // Handle profile picture change
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Consumer<ProfileProvider>(
                builder: (context, profileProvider, _) {
                  return Column(
                    children: [
                      CustomText(
                        text: profileProvider.user?.name ?? "",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      CustomText(
                        text: profileProvider.user?.name ?? "",
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              TabBarSection(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle update action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text("Update", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TabController tabController =
        TabController(length: 2, vsync: Scaffold.of(context));
    return Column(
      children: [
        TabBar(
          controller: tabController,
          labelColor: primarySolidColor,
          unselectedLabelColor: Colors.black,
          indicatorColor: primarySolidColor,
          tabs: const [
            Tab(text: "Basic Info"),
            Tab(text: "Password"),
          ],
        ),
        SizedBox(
          height: 500.h,
          child: TabBarView(
            controller: tabController,
            children: const [
              BasicInfoTab(),
              PasswordTab(),
            ],
          ),
        ),
      ],
    );
  }
}

class BasicInfoTab extends StatelessWidget {
  const BasicInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleFromField( // Corrected 'CustomTitleFromField' to 'CustomTitleFromField'
              title: "Full Name",
              hintText: "Enter your name",
              controller: profileProvider.nameController,
            ),
            const SizedBox(height: 8),
            CustomTitleFromField(
              title: "Email Address",
              hintText: "Enter your email",
              controller: profileProvider.emailController,
            ),
            const SizedBox(height: 8),
            CustomTitleFromField(
              title: "Phone Number",
              hintText: "Enter your phone number",
              controller: profileProvider.phoneController,
            ),
            const SizedBox(height: 8),
            CustomTitleFromField(
              title: "Date of Birth",
              hintText: "Enter your date of birth",
              suffixIcon: const Icon(Icons.calendar_today),
              controller: profileProvider.dobController,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class PasswordTab extends StatelessWidget {
  const PasswordTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPasswordFromField(  
              title: "Current Password",
              hintText: "Enter current password",
            ),
            SizedBox(height: 8),
            CustomPasswordFromField(
              title: "New Password",
              hintText: "Enter new password",
            ),
            SizedBox(height: 8),
            CustomPasswordFromField(
              title: "Re-enter New Password",
              hintText: "Re-enter new password",
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
