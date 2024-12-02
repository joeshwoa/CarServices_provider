// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));

String notificationsToJson(Notifications data) => json.encode(data.toJson());

class Notifications {
  List<WelcomeDatum>? data;
  Links? links;
  Meta? meta;
  int? totalUnseen;

  Notifications({
    this.data,
    this.links,
    this.meta,
    this.totalUnseen
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    data: json["data"] == null ? [] : List<WelcomeDatum>.from(json["data"]!.map((x) => WelcomeDatum.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    totalUnseen: json["total_unseen"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "total_unseen": totalUnseen,
  };
}

class WelcomeDatum {
  int? id;
  int? sellerId;
  String? title;
  String? body;
  List<DatumDatum>? data;
  int? read;
  int? orderId;
  DateTime? createdAt;
  DateTime? updatedAt;

  WelcomeDatum({
    this.id,
    this.sellerId,
    this.title,
    this.body,
    this.data,
    this.read,
    this.orderId,
    this.createdAt,
    this.updatedAt,
  });

  factory WelcomeDatum.fromJson(Map<String, dynamic> json) => WelcomeDatum(
    id: json["id"],
    sellerId: json["seller_id"],
    title: json["title"],
    body: json["body"],
    data: json["data"] == null ? [] : List<DatumDatum>.from(json["data"]!.map((x) => DatumDatum.fromJson(x))),
    read: json["read"],
    orderId: json["order_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seller_id": sellerId,
    "title": title,
    "body": body,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "read": read,
    "order_id": orderId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class DatumDatum {
  String? type;
  int? orderId;
  int? notificationId;

  DatumDatum({
    this.type,
    this.orderId,
    this.notificationId,
  });

  factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
    type: json["type"],
    orderId: json["order_id"],
    notificationId: json["notification_id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "order_id": orderId,
    "notification_id": notificationId,
  };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
