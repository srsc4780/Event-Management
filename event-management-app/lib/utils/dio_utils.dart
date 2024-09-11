import 'package:flutter/material.dart';

class DioUtils{
  static late TextStyle textStyle;
  static late Color primaryColor;
  static late String authRoute;
  static late String lang;
  static late String? authConfirm;
  static late String? authBack;
  static late String? authSentence;
  static late Function() dismissDialog;
  static late Function()? onAuthClick;
  static late Function() showLoadingDialog;
  static late Map<String, String>? header;

  static init(
      {required String baseUrl,
        String? branch,
        String? branchKey,
        required TextStyle style,
        required Color primary,
        required String authLink,
        required String language,
        String? authConfirm,
        String? authBack,
        String? authSentence,
        Map<String, String>? dioHeader,
        required Function() dismissFunc,
        required Function()? authClick,
        required Function() showLoadingFunc}){
    textStyle=style;
    primaryColor=primary;
    authRoute=authLink;
    lang=language;
    dismissDialog=dismissFunc;
    onAuthClick=authClick;
    DioUtils.authConfirm=authConfirm;
    DioUtils.authBack=authBack;
    DioUtils.authSentence=authSentence;
    showLoadingDialog=showLoadingFunc;
    DioUtils.header = dioHeader;
  }



}