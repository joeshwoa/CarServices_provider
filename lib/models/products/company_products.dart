// To parse this JSON data, do
//
//     final companyProducts = companyProductsFromJson(jsonString);

import 'dart:convert';

CompanyProducts companyProductsFromJson(String str) =>
    CompanyProducts.fromJson(json.decode(str));

String companyProductsToJson(CompanyProducts data) =>
    json.encode(data.toJson());

class CompanyProducts {
  List<Item>? data;

  CompanyProducts({
    this.data,
  });

  factory CompanyProducts.fromJson(Map<String, dynamic> json) =>
      CompanyProducts(
        data: json["data"] == null
            ? []
            : List<Item>.from(json["data"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Item {
  int? id;
  String? name;
  int? productId;

  Item({
    this.id,
    this.name,
    this.productId,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_id": productId,
      };
}
