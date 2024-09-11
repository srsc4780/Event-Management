import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/local/local_auth_provider.dart';
import 'package:sales_tracker/data/model/user_model.dart';
import 'package:sales_tracker/pages/auth_pages/login/view/login_page.dart';
import 'package:sales_tracker/pages/bottom_nav_bar/custom_bottom_nav.dart';
import 'package:sales_tracker/pages/edit_profile/view/edit_profile.dart';
import 'package:sales_tracker/pages/notification/view/notification_page.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/utils.dart';
import 'package:sales_tracker/utils/widgets/custom_app_bar.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';

class ProfilePage extends StatefulWidget {
  final bool? bottomNav;
  const ProfilePage({super.key, this.bottomNav});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final localAuthProvider =
          Provider.of<LocalAutProvider>(context, listen: false);
      final user = localAuthProvider.getUser();
      if (user == null) {
        NavUtil.pushAndRemoveUntil(context, const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localAuthProvider = Provider.of<LocalAutProvider>(context);
    final user = localAuthProvider.getUser();
    if (user == null) {
      return const LoginPage();
    }

    return Scaffold(
      backgroundColor: white,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            _buildProfileTile(user),
            const Divider(),
            const SizedBox(height: 10),
            _buildSectionHeader('Others'),
            _buildLogoutTile(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return widget.bottomNav == true
        ? AppBar(
            title: const Text('Profile'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          )
        : PreferredSize(
            preferredSize: Size.fromHeight(55.h),
            child: const CustomAppBar(appBarName: 'Profile'),
          );
  }

  Widget _buildProfileTile(UserModel user) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/image/User_image.png'),
        radius: 30,
      ),
      title: CustomText(
        text: user.name ?? 'Shop Owner',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        NavUtil.navigateScreen(context, const EditProfileScreen());
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return CustomText(
      text: title,
      fontSize: 12.r,
      fontWeight: FontWeight.w700,
      color: bodyTextColor,
    );
  }

  Widget _buildGeneralSection(UserModel user) {
    return Column(
      children: [
        _buildListTile("assets/profile_icon/product_icon.png", 'Products', () {
           NavUtil.navigateScreen(
            context, const CustomBottomNavBar(bottomNavigationIndex: 1));
        }),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      children: [
        _buildListTile(
            "assets/profile_icon/notification_icon.png", 'Notifications', () {
          NavUtil.navigateScreen(context, const NotificationPage());
        }),
      ],
    );
  }


  Widget _buildLogoutTile(BuildContext context) {
    return _buildListTile(
      'assets/profile_icon/logout_icon.png',
      'Logout',
      () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                context.read<LocalAutProvider>().deleteUser();
                NavUtil.pushAndRemoveUntil(context, const LoginPage());
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String asset, String title, Function()? onTap) {
    return ListTile(
      leading: Image.asset(
        asset,
        height: 32.h,
        width: 32.w,
      ),
      title: CustomText(text: title, fontSize: 16),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
