import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';

class LoadingDialog {
  static showLoadingDialog() {
    EasyLoading.show(
        dismissOnTap: false,
        indicator: SpinKitCircle(
          size: 40.0,
          itemBuilder: (context, index) {
            return Container(
              height: 10,
              width: 10,
              margin: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                  color: primarySolidColor, shape: BoxShape.circle),
            );
          },
        ),
        status: "loading");
  }

  static showLoadingView({Color? color}) {
    return Center(
      child: SpinKitCircle(
        color: color ?? primarySolidColor,
        size: 40.0,
      ),
    );
  }

  static showToastNotification(msg,
      {Color? color, Color? textColor, ToastGravity? toastGravity}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: toastGravity ?? ToastGravity.BOTTOM,
        backgroundColor: color ?? primarySolidColor,
        textColor: textColor ?? Colors.white,
        fontSize: 16.0);
  }
}
