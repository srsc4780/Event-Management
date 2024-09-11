import 'package:flutter/material.dart';
import 'package:sales_tracker/data/model/dashboard_model.dart';
import 'package:sales_tracker/data/network/repository/repository.dart';
import 'package:sales_tracker/utils/utils.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardModel? dashboardResponse;

  DashboardProvider(BuildContext context) {
    getDashboardData(context);
  }

  void getDashboardData(BuildContext context) async {
   printDebug("dashboard");
    var apiResponse = await RepositoryImpl(context).getDashboardData();
    if (apiResponse != null) {
      printDebug("apiResponse.data ${apiResponse.message}");
      dashboardResponse = apiResponse;
    }
    notifyListeners();
  }
}
