import 'dart:convert';

Month monthFromJson(Map<String, dynamic> str) => Month.fromJson(str);

String monthToJson(Month data) => json.encode(data.toJson());

class Month {
  String? month;
  String? year;
  int? completed;
  int? rejected;
  int? failed;

  Month({
    this.month,
    this.year,
    this.completed,
    this.rejected,
    this.failed,
  });

  factory Month.fromJson(Map<String, dynamic> json) => Month(
    month: json["month"],
    year: json["year"].toString(),
    completed: json["completed"]*1000,
    rejected: json["rejected"]*1000,
    failed: json["failed"]*1000,
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "year": year,
    "completed": completed,
    "rejected": rejected,
    "failed": failed,
  };
}
