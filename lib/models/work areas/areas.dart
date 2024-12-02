// To parse this JSON data, do
//
//     final areas = areasFromJson(jsonString);

import 'dart:convert';

Areas areasFromJson(String str) => Areas.fromJson(json.decode(str));

String areasToJson(Areas data) => json.encode(data.toJson());

class Areas {
  List<Area>? data;

  Areas({
    this.data,
  });

  factory Areas.fromJson(Map<String, dynamic> json) => Areas(
        data: json["data"] == null
            ? []
            : List<Area>.from(json["data"]!.map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Area {
  int? id;
  String? name;
  int? emirateId;

  Area({
    this.id,
    this.name,
    this.emirateId,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
        emirateId: json["emirate_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "emirate_id": emirateId,
      };
}
