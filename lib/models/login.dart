// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    Data? data;
    String? message;
    String? token;

    Login({
        this.data,
        this.message,
        this.token,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "token": token,
    };
}

class Data {
    int? id;
    String? email;
    String? fullName;
    dynamic firstName;
    dynamic lastName;
    dynamic gender;
    dynamic dateOfBirth;
    String? phone;
    dynamic whatsappNumber;
    dynamic status;
    dynamic notes;
    String? logo;
    bool? hasCompany;
    bool? isApproved;
    bool? isCompleted;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.email,
        this.fullName,
        this.firstName,
        this.lastName,
        this.gender,
        this.dateOfBirth,
        this.phone,
        this.whatsappNumber,
        this.status,
        this.notes,
        this.logo,
        this.hasCompany,
        this.isApproved,
        this.isCompleted,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        fullName: json["full_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        phone: json["phone"],
        whatsappNumber: json["whatsapp_number"],
        status: json["status"],
        notes: json["notes"],
        logo: json["logo"],
        hasCompany: json["has_company"],
        isApproved: json["is_approved"],
        isCompleted: json["is_completed"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "full_name": fullName,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "phone": phone,
        "whatsapp_number": whatsappNumber,
        "status": status,
        "notes": notes,
        "logo": logo,
        "has_company": hasCompany,
        "is_approved": isApproved,
        "is_completed": isCompleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
