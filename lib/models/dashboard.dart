import 'dart:convert';

class DashboardInfo {
  final int todayBookings;
  final int todayBooked;
  final int todayCheckedIn;
  final int todayAvailableRoom;
  final int todayCollection;
  DashboardInfo({
    required this.todayBookings,
    required this.todayBooked,
    required this.todayCheckedIn,
    required this.todayAvailableRoom,
    required this.todayCollection,
  });

  DashboardInfo copyWith({
    int? todayBookings,
    int? todayBooked,
    int? todayCheckedIn,
    int? todayAvailableRoom,
    int? todayCollection,
  }) {
    return DashboardInfo(
      todayBookings: todayBookings ?? this.todayBookings,
      todayBooked: todayBooked ?? this.todayBooked,
      todayCheckedIn: todayCheckedIn ?? this.todayCheckedIn,
      todayAvailableRoom: todayAvailableRoom ?? this.todayAvailableRoom,
      todayCollection: todayCollection ?? this.todayCollection,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todayBookings': todayBookings,
      'todayBooked': todayBooked,
      'todayCheckedIn': todayCheckedIn,
      'todayAvailableRoom': todayAvailableRoom,
      'todayCollection': todayCollection,
    };
  }

  factory DashboardInfo.fromMap(Map<String, dynamic> map) {
    return DashboardInfo(
      todayBookings: map['todayBookings'].toInt() as int,
      todayBooked: map['todayBooked'].toInt() as int,
      todayCheckedIn: map['todayCheckedIn'].toInt() as int,
      todayAvailableRoom: map['todayAvailableRoom'].toInt() as int,
      todayCollection: map['todayCollection'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardInfo.fromJson(String source) => DashboardInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DashboardInfo(todayBookings: $todayBookings, todayBooked: $todayBooked, todayCheckedIn: $todayCheckedIn, todayAvailableRoom: $todayAvailableRoom, todayCollection: $todayCollection)';
  }

  @override
  bool operator ==(covariant DashboardInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.todayBookings == todayBookings &&
      other.todayBooked == todayBooked &&
      other.todayCheckedIn == todayCheckedIn &&
      other.todayAvailableRoom == todayAvailableRoom &&
      other.todayCollection == todayCollection;
  }

  @override
  int get hashCode {
    return todayBookings.hashCode ^
      todayBooked.hashCode ^
      todayCheckedIn.hashCode ^
      todayAvailableRoom.hashCode ^
      todayCollection.hashCode;
  }
}