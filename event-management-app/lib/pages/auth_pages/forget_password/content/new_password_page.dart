import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_tracker/pages/auth_pages/login/view/login_page.dart';
import 'package:sales_tracker/utils/nav_utail.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/widgets/custom_app_bar.dart';
import 'package:sales_tracker/utils/widgets/custom_text.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: const CustomAppBar(appBarName: 'New Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: 'New Password',
                  color: Colors.black,
                  fontSize: 14.r,
                  fontWeight: FontWeight.w700),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                // controller: widget.controller,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: borderColor.withOpacity(0.5), width: 1.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
                    hintText: '***********',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: bodyTextColor.withOpacity(0.3)),
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey.withOpacity(.4),
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    hintStyle: TextStyle(
                        fontSize: 14.r,
                        color: bodyTextColor,
                        fontWeight: FontWeight.w400),
                    border: const OutlineInputBorder()),
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomText(
                  text: 'Confirm Password',
                  color: Colors.black,
                  fontSize: 14.r,
                  fontWeight: FontWeight.w700),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                // controller: widget.controller,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: borderColor.withOpacity(0.5), width: 1.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
                    hintText: '***********',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: bodyTextColor.withOpacity(0.3)),
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey.withOpacity(.4),
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    hintStyle: TextStyle(
                        fontSize: 14.r,
                        color: bodyTextColor,
                        fontWeight: FontWeight.w400),
                    border: const OutlineInputBorder()),
              ),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                height: 24.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                  elevation: 5,
                ),
                onPressed: () {},
                child: Ink(
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
                      // constraints: const BoxConstraints(minWidth: 88.0),
                      child: Center(
                        child: Text('SUBMIT',
                            style: TextStyle(color: white),
                            textAlign: TextAlign.center),
                      )),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  CustomText(
                      text: 'Already have an account?',
                      color: bodyTextColor,
                      fontSize: 14.r,
                      fontWeight: FontWeight.w500),
                  InkWell(
                    onTap: () {
                      NavUtil.navigateScreen(context, const LoginPage());
                    },
                    child: CustomText(
                        text: 'Sign In',
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
  }
}
