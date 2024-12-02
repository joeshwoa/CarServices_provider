// To parse this JSON data, do
//
//     final companyWorkers = companyWorkersFromJson(jsonString);

import 'dart:convert';

CompanyWorkers companyWorkersFromJson(String str) =>
    CompanyWorkers.fromJson(json.decode(str));

String companyWorkersToJson(CompanyWorkers data) => json.encode(data.toJson());

class CompanyWorkers {
  List<CompanyWorker>? data;

  CompanyWorkers({
    this.data,
  });

  factory CompanyWorkers.fromJson(Map<String, dynamic> json) => CompanyWorkers(
        data: json["data"] == null
            ? []
            : List<CompanyWorker>.from(
                json["data"]!.map((x) => CompanyWorker.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CompanyWorker {
  int? id;
  String? username;
  String? fullName;
  String? phone;
  dynamic whatsappNumber;
  int? companyId;
  String? title;
  String? image;
  List<Category>? categories;
  DateTime? createdAt;
  DateTime? updatedAt;

  CompanyWorker({
    this.id,
    this.username,
    this.fullName,
    this.phone,
    this.whatsappNumber,
    this.companyId,
    this.title,
    this.image,
    this.categories,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyWorker.fromJson(Map<String, dynamic> json) => CompanyWorker(
        id: json["id"],
        username: json["username"],
        fullName: json["full_name"],
        phone: json["phone"],
        whatsappNumber: json["whatsapp_number"],
        companyId: json["company_id"],
        title: json["title"],
        image: json["image"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "full_name": fullName,
        "phone": phone,
        "whatsapp_number": whatsappNumber,
        "company_id": companyId,
        "title": title,
        "image": image,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Category {
  int? id;
  String? name;
  String? slug;

  Category({
    this.id,
    this.name,
    this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}
