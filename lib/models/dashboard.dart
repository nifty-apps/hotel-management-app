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
  final int bookedRooms;
  final int availableRooms;
  final int todayBookings;
  Summary({
    required this.totalRooms,
    required this.bookedRooms,
    required this.availableRooms,
    required this.todayBookings,
  });

  Summary copyWith({
    int? totalRooms,
    int? bookedRooms,
    int? availableRooms,
    int? todayBookings,
  }) {
    return Summary(
      totalRooms: totalRooms ?? this.totalRooms,
      bookedRooms: bookedRooms ?? this.bookedRooms,
      availableRooms: availableRooms ?? this.availableRooms,
      todayBookings: todayBookings ?? this.todayBookings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalRooms': totalRooms,
      'bookedRooms': bookedRooms,
      'availableRooms': availableRooms,
      'todayBookings': todayBookings,
    };
  }

  factory Summary.fromMap(Map<String, dynamic> map) {
    return Summary(
      totalRooms: map['totalRooms'].toInt() as int,
      bookedRooms: map['bookedRooms'].toInt() as int,
      availableRooms: map['availableRooms'].toInt() as int,
      todayBookings: map['todayBookings'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Summary.fromJson(String source) =>
      Summary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Summary(totalRooms: $totalRooms, bookedRooms: $bookedRooms, availableRooms: $availableRooms, todayBookings: $todayBookings)';
  }

  @override
  bool operator ==(covariant Summary other) {
    if (identical(this, other)) return true;

    return other.totalRooms == totalRooms &&
        other.bookedRooms == bookedRooms &&
        other.availableRooms == availableRooms &&
        other.todayBookings == todayBookings;
  }

  @override
  int get hashCode {
    return totalRooms.hashCode ^
        bookedRooms.hashCode ^
        availableRooms.hashCode ^
        todayBookings.hashCode;
  }
}
