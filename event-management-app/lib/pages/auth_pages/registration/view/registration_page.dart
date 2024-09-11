import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/porvider/registration_provider.dart';
import 'package:sales_tracker/pages/auth_pages/login/view/login_page.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_password_form_field.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';
import 'package:sales_tracker/utils/widgets/custom_title_form_field.dart';

class CreateRegistrationPage extends StatelessWidget {
  final RegistrationProvider? provider;
  const CreateRegistrationPage({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: formKey,
        child: Consumer<RegistrationProvider>(builder: (context, p, _) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/image/app_logo.png',
                        height: 60.h,
                        width: 60.w,
                      ),
                    ),
                    CustomText(
                      text: "Register",
                      fontSize: 22.r,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: "Create an account to continue!",
                      fontSize: 14.r,
                      fontWeight: FontWeight.w400,
                      color: bodyTextColor,
                    ),
                    SizedBox(height: 20.h),

                    // Name field
                    CustomTitleFromField(
                      title: 'Name',
                      hintText: 'Enter your name',
                      controller: p.nameController,
                      errorText: p.nameError, // Show the name error
                    ),
                    SizedBox(height: 5.h),

                    // Email field
                    CustomTitleFromField(
                      title: 'Email',
                      hintText: 'Enter your email',
                      controller: p.emailController,
                      keyboardType: TextInputType.emailAddress,
                      errorText: p.emailError, // Show the email error
                    ),
                    SizedBox(height: 5.h),

                    // Password field
                    CustomPasswordFromField(
                      title: 'Password',
                      hintText: 'Enter your password',
                      controller: p.passController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      errorText: p.passwordError, // Show the password error
                    ),
                    SizedBox(height: 5.h),

                    // Confirm Password field
                    CustomPasswordFromField(
                      title: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      controller: p.confirmPassController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != p.passController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0.0),
                            elevation: 5,
                          ),
                          onPressed: p.isLoading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    p.postRegister(context);
                                  }
                                },
                          child: p.isLoading
                              ? const CircularProgressIndicator()
                              : Ink(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Color(0xffFF5A70),
                                        Color(0xffB50820),
                                        Color(0xffFF5A70)
                                      ], tileMode: TileMode.decal),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const SizedBox(
                                      height: 45,
                                      width: 120,
                                      child: Center(
                                        child: Text('Submit',
                                            style: TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center),
                                      )),
                                ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: 'If you have an account? ',
                            color: bodyTextColor,
                            fontSize: 14.r,
                            fontWeight: FontWeight.w500),
                        InkWell(
                          onTap: () {
                            NavUtil.navigateScreen(context, const LoginPage());
                          },
                          child: CustomText(
                              text: 'Login',
                              color: primarySolidColor,
                              fontSize: 14.r,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
