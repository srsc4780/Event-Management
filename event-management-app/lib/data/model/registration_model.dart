// To parse this JSON data, do
//
//     final userRegistration = userRegistrationFromJson(jsonString);

import 'dart:convert';

UserRegistration userRegistrationFromJson(String str) => UserRegistration.fromJson(json.decode(str));

String userRegistrationToJson(UserRegistration data) => json.encode(data.toJson());

class UserRegistration {
    bool success;
    String message;
    Data data;

    UserRegistration({
        required this.success,
        required this.message,
        required this.data,
    });

    factory UserRegistration.fromJson(Map<String, dynamic> json) => UserRegistration(
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
    String uid;
    String email;
    String name;

    Data({
        required this.uid,
        required this.email,
        required this.name,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        uid: json["uid"],
        email: json["email"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
    };
}
