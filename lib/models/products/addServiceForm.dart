// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Data? data;
  String? message;

  Product({
    this.data,
    this.message,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? id;
  String? name;
  String? sku;
  List<PriceList>? priceList;
  List<String>? description;
  List<AddOn>? addOns;
  String? duration;
  bool? powerOutlet;
  List<String>? additionalInformation;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.name,
    this.sku,
    this.priceList,
    this.description,
    this.addOns,
    this.duration,
    this.powerOutlet,
    this.additionalInformation,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        priceList: json["price_list"] == null
            ? []
            : List<PriceList>.from(
                json["price_list"]!.map((x) => PriceList.fromJson(x))),
        description: json["description"] == null
            ? []
            : List<String>.from(json["description"]!.map((x) => x)),
        addOns: json["add_ons"] == null
            ? []
            : List<AddOn>.from(json["add_ons"]!.map((x) => AddOn.fromJson(x))),
        duration: json["duration"],
        powerOutlet: json["power_outlet"],
        additionalInformation: json["additional_information"] == null
            ? []
            : List<String>.from(json["additional_information"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku": sku,
        "price_list": priceList == null
            ? []
            : List<dynamic>.from(priceList!.map((x) => x.toJson())),
        "description": description == null
            ? []
            : List<dynamic>.from(description!.map((x) => x)),
        "add_ons": addOns == null
            ? []
            : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "duration": duration,
        "power_outlet": powerOutlet,
        "additional_information": additionalInformation == null
            ? []
            : List<dynamic>.from(additionalInformation!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class AddOn {
  int? id;
  String? name;
  double? price;
  bool? multiQty;
  String? formattedPrice;
  String? description;
  int? productId;
  int? sellerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  AddOn({
    this.id,
    this.name,
    this.price,
    this.multiQty,
    this.formattedPrice,
    this.description,
    this.productId,
    this.sellerId,
    this.createdAt,
    this.updatedAt,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        multiQty: json["multi_qty"],
        formattedPrice: json["formatted_price"],
        description: json["description"],
        productId: json["product_id"],
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
        "name": name,
        "price": price,
        "multi_qty": multiQty,
        "formatted_price": formattedPrice,
        "description": description,
        "product_id": productId,
        "seller_id": sellerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PriceList {
  int? carTypeId;
  String? carType;
  double? price;

  PriceList({
    this.carTypeId,
    this.carType,
    this.price,
  });

  factory PriceList.fromJson(Map<String, dynamic> json) => PriceList(
        carTypeId: json["car_type_id"],
        carType: json["car_type"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "car_type_id": carTypeId,
        "car_type": carType,
        "price": price,
      };
}

VehicleTypes vehicleTypesFromJson(String str) =>
    VehicleTypes.fromJson(json.decode(str));

String vehicleTypesToJson(VehicleTypes data) => json.encode(data.toJson());

class VehicleTypes {
  List<Datum>? data;

  VehicleTypes({
    this.data,
  });

  factory VehicleTypes.fromJson(Map<String, dynamic> json) => VehicleTypes(
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
  String? name;

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
