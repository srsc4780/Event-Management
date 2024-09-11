// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductListModel {
  final bool? result;
  final String? message;
  final Data? data;

  ProductListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        result: json["result"] ?? false,
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final List<Datum>? data;
  final Meta? meta;

  Data({
    this.data,
    this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Datum {
  final int? id;
  final String? name;
  final int? mrp;
  final int? categoryId;
  final int? agentPoint;
  final String? image;
  final String? unit;
  final int? status;
  final String? category;
  final dynamic description;

  Datum({
    this.id,
    this.name,
    this.mrp,
    this.categoryId,
    this.agentPoint,
    this.image,
    this.unit,
    this.status,
    this.category,
    this.description,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        mrp: json["mrp"],
        categoryId: json["category_id"],
        agentPoint: json["agent_point"],
        image: json["image"],
        unit: json["unit"],
        status: json["status"],
        category: json["category"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mrp": mrp,
        "category_id": categoryId,
        "agent_point": agentPoint,
        "image": image,
        "unit": unit,
        "status": status,
        "category": category,
        "description": description,
      };
}

class Meta {
  final int? currentPage;
  final int? perPage;
  final int? total;
  final int? lastPage;
  final dynamic nextPageUrl;
  final dynamic prevPageUrl;

  Meta({
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        perPage: json["per_page"],
        total: json["total"],
        lastPage: json["last_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "per_page": perPage,
        "total": total,
        "last_page": lastPage,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
      };
}
