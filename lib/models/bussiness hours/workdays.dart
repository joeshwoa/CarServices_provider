// To parse this JSON data, do
//
//     final workDays = workDaysFromJson(jsonString);

import 'dart:convert';

WorkDays workDaysFromJson(String str) => WorkDays.fromJson(json.decode(str));

String workDaysToJson(WorkDays data) => json.encode(data.toJson());

class WorkDays {
  List<Datum>? data;

  WorkDays({
    this.data,
  });

  factory WorkDays.fromJson(Map<String, dynamic> json) => WorkDays(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? day;
  bool? allDay;
  int? sellerId;
  String? from;
  String? to;
  bool? datumBreak;
  String? breakFrom;
  String? breakTo;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.day,
    this.allDay,
    this.sellerId,
    this.from,
    this.to,
    this.datumBreak,
    this.breakFrom,
    this.breakTo,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        day: json["day"],
        allDay: json["all_day"],
        sellerId: json["seller_id"],
        from: json["from"],
        to: json["to"],
        datumBreak: json["break"],
        breakFrom: json["break_from"],
        breakTo: json["break_to"],
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
        "all_day": allDay,
        "seller_id": sellerId,
        "from": from,
        "to": to,
        "break": datumBreak,
        "break_from": breakFrom,
        "break_to": breakTo,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
