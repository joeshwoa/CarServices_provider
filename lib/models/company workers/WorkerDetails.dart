// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

WorkerDetails workerDetailsFromJson(String str) => WorkerDetails.fromJson(json.decode(str));

String workerDetailsToJson(WorkerDetails data) => json.encode(data.toJson());

class WorkerDetails {
  Data? data;

  WorkerDetails({
    this.data,
  });

  factory WorkerDetails.fromJson(Map<String, dynamic> json) => WorkerDetails(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? username;
  String? fullName;
  String? phone;
  String? whatsappNumber;
  int? companyId;
  String? title;
  String? image;
  List<dynamic>? categories;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    username: json["username"],
    fullName: json["full_name"],
    phone: json["phone"],
    whatsappNumber: json["whatsapp_number"],
    companyId: json["company_id"],
    title: json["title"],
    image: json["image"],
    categories: json["categories"] == null ? [] : List<dynamic>.from(json["categories"]!.map((x) => x)),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
