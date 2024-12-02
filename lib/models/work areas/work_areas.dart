// To parse this JSON data, do
//
//     final workAreas = workAreasFromJson(jsonString);

import 'dart:convert';

WorkAreas workAreasFromJson(String str) => WorkAreas.fromJson(json.decode(str));

String workAreasToJson(WorkAreas data) => json.encode(data.toJson());

class WorkAreas {
  List<Datum>? data;

  WorkAreas({
    this.data,
  });

  factory WorkAreas.fromJson(Map<String, dynamic> json) => WorkAreas(
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
  int? cityId;
  int? emirateId;
  int? sellerId;
  String? reachTime;

  Datum({
    this.id,
    this.cityId,
    this.emirateId,
    this.sellerId,
    this.reachTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        cityId: json["city_id"],
        emirateId: json["emirate_id"],
        sellerId: json["seller_id"],
        reachTime: json["reach_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "emirate_id": emirateId,
        "seller_id": sellerId,
        "reach_time": reachTime,
      };
}
