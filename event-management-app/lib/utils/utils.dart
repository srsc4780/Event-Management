import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_tracker/data/network/api/api_provider.dart';
import 'package:sales_tracker/utils/dialog/loading_dialog.dart';
import 'package:sales_tracker/utils/dio_utils.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:flutter/foundation.dart' as foundation;

class Utils {
  static initDio() {
    DioUtils.init(
        baseUrl: ApiProvider.baseUrl,
        style: GoogleFonts.manrope(),
        primary: primarySolidColor,
        authLink: '',
        language: '',
        dismissFunc: EasyLoading.dismiss,
        authClick: null,
        showLoadingFunc: LoadingDialog.showLoadingDialog);
  }
}

void printDebug(data) {
  if (foundation.kDebugMode) {
    print(data);
  }
}


