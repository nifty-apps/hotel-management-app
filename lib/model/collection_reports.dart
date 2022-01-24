// To parse this JSON data, do
//
//     final reports = reportsFromJson(jsonString);

import 'dart:convert';

Reports reportsFromJson(String str) => Reports.fromJson(json.decode(str));

String reportsToJson(Reports data) => json.encode(data.toJson());

class Reports {
  Reports({
    this.todayCollection,
    this.yesterdayCollection,
    this.lastWeekCollection,
    this.lastMonthCollection,
    this.lastYearCollection,
  });

  int? todayCollection;
  int? yesterdayCollection;
  int? lastWeekCollection;
  int? lastMonthCollection;
  int? lastYearCollection;

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
        todayCollection: json["today_collection"],
        yesterdayCollection: json["yesterday_collection"],
        lastWeekCollection: json["last_week_collection"],
        lastMonthCollection: json["last_month_collection"],
        lastYearCollection: json["last_year_collection"],
      );

  Map<String, dynamic> toJson() => {
        "today_collection": todayCollection,
        "yesterday_collection": yesterdayCollection,
        "last_week_collection": lastWeekCollection,
        "last_month_collection": lastMonthCollection,
        "last_year_collection": lastYearCollection,
      };
}
