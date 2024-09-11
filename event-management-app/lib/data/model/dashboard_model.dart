// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
    bool success;
    String message;
    Data data;

    DashboardModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int totalEvents;
    int upcomingEventsCount;
    int leftEventsCount;
    int totalUsers;

    Data({
        required this.totalEvents,
        required this.upcomingEventsCount,
        required this.leftEventsCount,
        required this.totalUsers,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalEvents: json["totalEvents"],
        upcomingEventsCount: json["upcomingEventsCount"],
        leftEventsCount: json["leftEventsCount"],
        totalUsers: json["totalUsers"],
    );

    Map<String, dynamic> toJson() => {
        "totalEvents": totalEvents,
        "upcomingEventsCount": upcomingEventsCount,
        "leftEventsCount": leftEventsCount,
        "totalUsers": totalUsers,
    };
}
