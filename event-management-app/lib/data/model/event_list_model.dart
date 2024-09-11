import 'dart:convert';

// Function to deserialize JSON data
EventListModel eventListModelFromJson(String str) =>
    EventListModel.fromJson(json.decode(str));

// Function to serialize the object to JSON
String eventListModelToJson(EventListModel data) => json.encode(data.toJson());

class EventListModel {
  final bool success;
  final String message;
  final List<Event> data;

  EventListModel({
    required this.success,
    required this.message,
    required this.data,
  });

  // Factory method for JSON deserialization
  factory EventListModel.fromJson(Map<String, dynamic> json) => EventListModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] == null
            ? []
            : List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
      );

  // Method for JSON serialization
  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Event {
  final String id;
  final DateTime date;
  final String organizerId;
  final String organizer;
  final String location;
  final String eventType;
  final Timestamp createdAt;
  final String description;
  final String title;
  final Timestamp updatedAt;

  Event({
    required this.id,
    required this.date,
    required this.organizerId,
    required this.organizer,
    required this.location,
    required this.eventType,
    required this.createdAt,
    required this.description,
    required this.title,
    required this.updatedAt,
  });

  // Factory method for JSON deserialization
  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"] ?? "",
        date: DateTime.parse(json["date"] ?? DateTime.now().toIso8601String()),
        organizerId: json["organizerId"] ?? "",
        organizer: json["organizer"] ?? "",
        location: json["location"] ?? "",
        eventType: json["eventType"] ?? "",
        createdAt: Timestamp.fromJson(json["createdAt"]),
        description: json["description"] ?? "",
        title: json["title"] ?? "",
        updatedAt: Timestamp.fromJson(json["updatedAt"]),
      );

  // Method for JSON serialization
  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "organizerId": organizerId,
        "organizer": organizer,
        "location": location,
        "eventType": eventType,
        "createdAt": createdAt.toJson(),
        "description": description,
        "title": title,
        "updatedAt": updatedAt.toJson(),
      };
}

class Timestamp {
  final int seconds;
  final int nanoseconds;

  Timestamp({
    required this.seconds,
    required this.nanoseconds,
  });

  // Factory method for JSON deserialization
  factory Timestamp.fromJson(Map<String, dynamic> json) => Timestamp(
        seconds: json["_seconds"] ?? 0,
        nanoseconds: json["_nanoseconds"] ?? 0,
      );

  // Method for JSON serialization
  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };

  // Method to convert Timestamp to DateTime
  DateTime toDateTime() => DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
}
