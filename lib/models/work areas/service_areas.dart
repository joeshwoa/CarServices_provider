// To parse this JSON data, do
//
//     final serviceAreas = serviceAreasFromJson(jsonString);

import 'dart:convert';

ServiceAreas serviceAreasFromJson(String str) =>
    ServiceAreas.fromJson(json.decode(str));

String serviceAreasToJson(ServiceAreas data) => json.encode(data.toJson());

class ServiceAreas {
  List<Emirate>? data;

  ServiceAreas({
    this.data,
  });

  factory ServiceAreas.fromJson(Map<String, dynamic> json) => ServiceAreas(
        data: json["data"] == null
            ? []
            : List<Emirate>.from(json["data"]!.map((x) => Emirate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Emirate {
  int? id;
  String? emirateName;
  List<City>? cities;

  Emirate({
    this.id,
    this.emirateName,
    this.cities,
  });

  factory Emirate.fromJson(Map<String, dynamic> json) => Emirate(
        id: json["id"],
        emirateName: json["emirate_name"],
        cities: json["cities"] == null
            ? []
            : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emirate_name": emirateName,
        "cities": cities == null
            ? []
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class City {
  int? id;
  int? cityId;
  String? cityName;
  int? sellerId;
  String? reachTime;

  City({
    this.id,
    this.cityId,
    this.cityName,
    this.sellerId,
    this.reachTime,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        sellerId: json["seller_id"],
        reachTime: json["reach_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "city_name": cityName,
        "seller_id": sellerId,
        "reach_time": reachTime,
      };
}
