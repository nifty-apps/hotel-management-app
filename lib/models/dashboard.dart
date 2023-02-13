import 'dart:convert';

class DashboardInfo {
  final Summary summary;
  DashboardInfo({
    required this.summary,
  });

  DashboardInfo copyWith({
    Summary? summary,
  }) {
    return DashboardInfo(
      summary: summary ?? this.summary,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'summary': summary.toMap(),
    };
  }

  factory DashboardInfo.fromMap(Map<String, dynamic> map) {
    return DashboardInfo(
      summary: Summary.fromMap(map['summary'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardInfo.fromJson(String source) =>
      DashboardInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DashboardInfo(summary: $summary)';

  @override
  bool operator ==(covariant DashboardInfo other) {
    if (identical(this, other)) return true;

    return other.summary == summary;
  }

  @override
  int get hashCode => summary.hashCode;
}

class Summary {
  final int totalRooms;
  final int todayRevenue;
  final int todayBookings;
  final int todayCheckIn;
  Summary({
    required this.totalRooms,
    required this.todayRevenue,
    required this.todayBookings,
    required this.todayCheckIn,
  });

  Summary copyWith({
    int? totalRooms,
    int? bookedRooms,
    int? availableRooms,
    int? todayBookings,
  }) {
    return Summary(
      totalRooms: totalRooms ?? this.totalRooms,
      todayRevenue: bookedRooms ?? this.todayRevenue,
      todayBookings: availableRooms ?? this.todayBookings,
      todayCheckIn: todayBookings ?? this.todayCheckIn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalRooms': totalRooms,
      'todayRevenue': todayRevenue,
      'todayBookings': todayBookings,
      'todayCheckIn': todayCheckIn,
    };
  }

  factory Summary.fromMap(Map<String, dynamic> map) {
    return Summary(
      totalRooms: map['totalRooms'].toInt() as int,
      todayRevenue: map['todayRevenue'].toInt() as int,
      todayBookings: map['todayBookings'].toInt() as int,
      todayCheckIn: map['todayCheckIn'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Summary.fromJson(String source) =>
      Summary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Summary(totalRooms: $totalRooms, todayRevenue: $todayRevenue, todayBookings: $todayBookings, todayCheckIn: $todayCheckIn)';
  }

  @override
  bool operator ==(covariant Summary other) {
    if (identical(this, other)) return true;

    return other.totalRooms == totalRooms &&
        other.todayRevenue == todayRevenue &&
        other.todayBookings == todayBookings &&
        other.todayCheckIn == todayCheckIn;
  }

  @override
  int get hashCode {
    return totalRooms.hashCode ^
        todayRevenue.hashCode ^
        todayBookings.hashCode ^
        todayCheckIn.hashCode;
  }
}
