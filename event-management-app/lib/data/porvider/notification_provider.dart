import 'package:flutter/material.dart';
import 'package:sales_tracker/data/model/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationModel? notificationResponse;

  NotificationProvider(BuildContext context) {
    getNotificationData(context);
  }
  bool get isLoading => notificationResponse == null;

  void getNotificationData(BuildContext context) async {
    
  }
}
