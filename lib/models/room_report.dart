import 'dart:convert';

import 'package:flutter/foundation.dart';

class RoomReport {
  final String roomNumber;
  final List<Report> report;
  RoomReport({
    required this.roomNumber,
    required this.report,
  });

  RoomReport copyWith({
    String? roomNumber,
    List<Report>? report,
  }) {
    return RoomReport(
      roomNumber: roomNumber ?? this.roomNumber,
      report: report ?? this.report,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomNumber': roomNumber,
      'report': report.map((x) => x.toMap()).toList(),
    };
  }

  factory RoomReport.fromMap(Map<String, dynamic> map) {
    return RoomReport(
      roomNumber: map['roomNumber'] as String,
      report: List<Report>.from(
        (map['report'] as List<dynamic>).map<Report>(
          (x) => Report.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomReport.fromJson(String source) =>
      RoomReport.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RoomReport(roomNumber: $roomNumber, report: $report)';

  @override
  bool operator ==(covariant RoomReport other) {
    if (identical(this, other)) return true;

    return other.roomNumber == roomNumber && listEquals(other.report, report);
  }

  @override
  int get hashCode => roomNumber.hashCode ^ report.hashCode;
}

class Report {
  final String date;
  final String status;
  Report({
    required this.date,
    required this.status,
  });

  Report copyWith({
    String? date,
    String? status,
  }) {
    return Report(
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'status': status,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      date: map['date'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Report(date: $date, status: $status)';

  @override
  bool operator ==(covariant Report other) {
    if (identical(this, other)) return true;

    return other.date == date && other.status == status;
  }

  @override
  int get hashCode => date.hashCode ^ status.hashCode;
}
