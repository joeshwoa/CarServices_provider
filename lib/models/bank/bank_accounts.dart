// To parse this JSON data, do
//
//     final accounts = accountsFromJson(jsonString);

import 'dart:convert';

Accounts accountsFromJson(String str) => Accounts.fromJson(json.decode(str));

String accountsToJson(Accounts data) => json.encode(data.toJson());

class Accounts {
  List<Datum>? data;

  Accounts({
    this.data,
  });

  factory Accounts.fromJson(Map<String, dynamic> json) => Accounts(
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
  String? bankName;
  String? accountTitle;
  String? accountNumber;
  String? iban;
  int? sellerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.bankName,
    this.accountTitle,
    this.accountNumber,
    this.iban,
    this.sellerId,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        bankName: json["bank_name"],
        accountTitle: json["account_title"],
        accountNumber: json["account_number"],
        iban: json["iban"],
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
        "bank_name": bankName,
        "account_title": accountTitle,
        "account_number": accountNumber,
        "iban": iban,
        "seller_id": sellerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
