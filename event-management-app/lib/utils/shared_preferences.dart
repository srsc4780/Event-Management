import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SPUtill {
  static String keySelectLanguage = "key_select_language";
  static String keyDocumentList = "key_document_list";

  static Future<int?> getRemoteModeType(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getInt(key);
      return value;
    } catch (error) {
      return null;
    }
  }

  static setDocumentPathList(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
  }



  static setLanguageIntValue(String key, int? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value!);
  }

  static Future<int?> getSelectLanguage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getInt(key);
      return value;
    } catch (error) {
      return null;
    }
  }
}
