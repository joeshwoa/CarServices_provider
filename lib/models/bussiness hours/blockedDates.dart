// To parse this JSON data, do
//
//     final blockedDates = blockedDatesFromJson(jsonString);

import 'dart:convert';

BlockedDates blockedDatesFromJson(String str) =>
    BlockedDates.fromJson(json.decode(str));

String blockedDatesToJson(BlockedDates data) => json.encode(data.toJson());

class BlockedDates {
  List<Date>? data;

  BlockedDates({
    this.data,
  });

  factory BlockedDates.fromJson(Map<String, dynamic> json) => BlockedDates(
        data: json["data"] == null
            ? []
            : List<Date>.from(json["data"]!.map((x) => Date.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Date {
  int? id;
  String? day;
  String? date;
  int? sellerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Date({
    this.id,
    this.day,
    this.date,
    this.sellerId,
    this.createdAt,
    this.updatedAt,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        id: json["id"],
        day: json["day"],
        date: json["date"],
        sellerId: json["seller_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "date": date,
        "seller_id": sellerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
