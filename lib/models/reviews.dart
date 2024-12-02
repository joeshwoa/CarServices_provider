// To parse this JSON data, do
//
//     final reviews = reviewsFromJson(jsonString);

import 'dart:convert';

Reviews reviewsFromJson(String str) => Reviews.fromJson(json.decode(str));

String reviewsToJson(Reviews data) => json.encode(data.toJson());

class Reviews {
    Data? data;

    Reviews({
        this.data,
    });

    factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    double? average;
    int? total;
    List<Review>? reviews;

    Data({
        this.average,
        this.total,
        this.reviews,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        average: json["average"]?.toDouble(),
        total: json["total"],
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "average": average,
        "total": total,
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    };
}

class Review {
    int? id;
    double? rating;
    String? title;
    String? comment;
    String? status;
    int? marketplaceSellerId;
    String? customerImage;
    String? customerName;
    DateTime? date;
    DateTime? createdAt;
    DateTime? updatedAt;

    Review({
        this.id,
        this.rating,
        this.title,
        this.comment,
        this.status,
        this.marketplaceSellerId,
        this.customerImage,
        this.customerName,
        this.date,
        this.createdAt,
        this.updatedAt,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        rating: json["rating"]?.toDouble(),
        title: json["title"],
        comment: json["comment"],
        status: json["status"],
        marketplaceSellerId: json["marketplace_seller_id"],
        customerImage: json["customer_image"],
        customerName: json["customer_name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "title": title,
        "comment": comment,
        "status": status,
        "marketplace_seller_id": marketplaceSellerId,
        "customer_image": customerImage,
        "customer_name": customerName,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
