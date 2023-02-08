import 'dart:convert';

class Room {
  final String id;
  final String floor;
  final String number;
  final String roomType;
  final int rent;
  final String hotel;
  Room({
    required this.id,
    required this.floor,
    required this.number,
    required this.roomType,
    required this.rent,
    required this.hotel,
  });

  Room copyWith({
    String? id,
    String? floor,
    String? number,
    String? roomType,
    int? rent,
    String? hotel,
  }) {
    return Room(
      id: id ?? this.id,
      floor: floor ?? this.floor,
      number: number ?? this.number,
      roomType: roomType ?? this.roomType,
      rent: rent ?? this.rent,
      hotel: hotel ?? this.hotel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'floor': floor,
      'number': number,
      'roomType': roomType,
      'rent': rent,
      'hotel': hotel,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['_id'] as String,
      floor: map['floor'] as String,
      number: map['number'] as String,
      roomType: map['roomType'] as String,
      rent: map['rent'].toInt() as int,
      hotel: map['hotel'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Room(id: $id, floor: $floor, number: $number, roomType: $roomType, rent: $rent, hotel: $hotel)';
  }

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.floor == floor &&
        other.number == number &&
        other.roomType == roomType &&
        other.rent == rent &&
        other.hotel == hotel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        floor.hashCode ^
        number.hashCode ^
        roomType.hashCode ^
        rent.hashCode ^
        hotel.hashCode;
  }
}
