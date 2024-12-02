import 'dart:convert';

import 'package:autoflex/models/month.dart';

Earning earningFromJson(String str) => Earning.fromJson(json.decode(str));

String earningToJson(Earning data) => json.encode(data.toJson());

class Earning {
  Data? data;

  Earning({
    this.data,
  });

  factory Earning.fromJson(Map<String, dynamic> json) => Earning(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  double? lifeTimeEarning;
  double? currentEarning;
  double? availableToWithdraw;
  int? newJobs;
  int? todayJobs;
  List<Month>? months;


  Data({
    this.lifeTimeEarning,
    this.currentEarning,
    this.availableToWithdraw,
    this.newJobs,
    this.todayJobs,
    this.months,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    lifeTimeEarning: (json["life_time_earning"]??0) * 1.0,
    currentEarning: (json["current_earning"]??0) * 1.0,
    availableToWithdraw: (json["available_to_withdraw"]??0) * 1.0,
    newJobs: json["new_jobs"],
    todayJobs: json["today_jobs"],
    months: List.generate(json["months"]!.length, (index) => monthFromJson(json["months"]![index]),),
  );

  Map<String, dynamic> toJson() => {
    "life_time_earning": lifeTimeEarning,
    "current_earning": currentEarning,
    "available_to_withdraw": availableToWithdraw,
    "new_jobs": newJobs,
    "today_jobs": todayJobs,
    "months": List.generate(months!.length, (index) => monthToJson(months![index]),),
  };
}
