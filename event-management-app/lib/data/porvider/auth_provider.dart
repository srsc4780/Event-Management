import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/model/registration_model.dart';
import 'package:sales_tracker/data/model/user_model.dart';
import 'package:sales_tracker/data/network/dio/global_state.dart';
import 'package:sales_tracker/data/network/repository/repository.dart';
import 'package:sales_tracker/pages/bottom_nav_bar/custom_bottom_nav.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/utils.dart';

import '../local/local_auth_provider.dart';

UserModel? userResponse;

class AuthProvider {
  Future<void> login(
      {required UserLogin userLogin, required BuildContext context}) async {
    printDebug("User Login Attempt");
    try {

        var data = {
        'email': userLogin.email,
        'password': userLogin.password,
      };
      final user = await RepositoryImpl(context).login(data);
      printDebug(user);
      if (user != null && user.token != null) {
        // Set token as global variable, so that we can use it anywhere in the application
        GlobalState.instance.set('token', user.token);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User Login Successfully")),
        );
        context.read<LocalAutProvider>().updateUser(UserModel(
              token: user.token,
              name: user.name,
              email: user.email,
            ));
        NavUtil.navigateScreen(
            context, const CustomBottomNavBar(bottomNavigationIndex: 0));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User Login Failed: Invalid token")),
        );
      }
    } catch (error) {
      printDebug("Login failed: ${error.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Login Failed! try again")),
      );
    }
  }

  // void registration(
  //     {required UserRegistration userRegistration,
  //     required BuildContext context}) async {
  //   await RepositoryImpl(context).registration(userRegistration).then((user) {
  //     if (user != null) {
  //       context.read<LocalAutProvider>().updateUser(user);
  //       // NavUtil.pushAndRemoveUntil(context, const CustomBottomNavBar());
  //     }
  //   });
  // }

  void forgetPass(
      {required String email, required BuildContext context}) async {
    final data = {"email": email};
    await RepositoryImpl(context).forgetPass(data).then((response) {
      if (response['status'] == 200) {
        // NavUtil.navigateScreen(context, const ResetPass());
      }
    });
  }

  void resetPass(
      {required String otp,
      required String email,
      required String password,
      required BuildContext context}) async {
    final data = {"otp": otp, "email": email, "password": password};
    print(data.toString());
    await RepositoryImpl(context).resetPass(data).then((response) {
      if (response['status'] == 200) {
        // NavUtil.pushAndRemoveUntil(context, const LoginScreen());
      }
    });
  }
}
