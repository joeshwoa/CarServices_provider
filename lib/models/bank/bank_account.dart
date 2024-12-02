// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  Data? data;

  Account({
    this.data,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? bankName;
  String? accountTitle;
  String? accountNumber;
  String? iban;
  int? sellerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.bankName,
    this.accountTitle,
    this.accountNumber,
    this.iban,
    this.sellerId,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
