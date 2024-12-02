// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  Data? data;
  String? message;

  Company({
    this.data,
    this.message,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
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
  String? phone;
  String? address;
  int? sellerId;
  String? logo;
  String? tradeLicense;
  String? ownerEmiratesId;
  String? passport;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.sellerId,
    this.logo,
    this.tradeLicense,
    this.ownerEmiratesId,
    this.passport,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        sellerId: json["seller_id"],
        logo: json["logo"],
        tradeLicense: json["trade_license"],
        ownerEmiratesId: json["owner_emirates_id"],
        passport: json["passport"],
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
        "phone": phone,
        "address": address,
        "seller_id": sellerId,
        "logo": logo,
        "trade_license": tradeLicense,
        "owner_emirates_id": ownerEmiratesId,
        "passport": passport,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
