import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/local/local_auth_provider.dart';
import 'package:sales_tracker/data/network/dio/global_state.dart';
import 'package:sales_tracker/pages/auth_pages/login/view/login_page.dart';
import 'package:sales_tracker/pages/bottom_nav_bar/custom_bottom_nav.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    final provider = Provider.of<LocalAutProvider>(context, listen: false);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    ///init dio service
    Utils.initDio();
    _animation = Tween(begin: 0.0, end: 2.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
    ));

    _animationController.forward();

    Timer(
      const Duration(seconds: 3),
      () {
        if (provider.getUser() != null) {
          ///set token as global variable, so that we can use
          ///anywhere in the application
          GlobalState.instance.set('token', provider.getUser()?.token);

          NavUtil.navigateScreen(context, const CustomBottomNavBar());
        } else {
          NavUtil.navigateScreen(context, const LoginPage());
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: white,
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/image/app_logo.png',
              height: 206.h,
              width: 163.w,
            ),
          ),
        ),
      ),
    );
  }
}
