import 'dart:convert';

import 'package:flutter/foundation.dart';

class AvailableRoom {
  final int count;
  final List<Room> rooms;
  final String type;
  AvailableRoom({
    required this.count,
    required this.rooms,
    required this.type,
  });

  AvailableRoom copyWith({
    String? id,
    int? count,
    List<Room>? rooms,
  }) {
    return AvailableRoom(
      count: count ?? this.count,
      rooms: rooms ?? this.rooms,
      type: type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'rooms': rooms.map((x) => x.toMap()).toList(),
      'type': type,
    };
  }

  factory AvailableRoom.fromMap(Map<String, dynamic> map) {
    return AvailableRoom(
      count: map['count'].toInt() as int,
      rooms: List<Room>.from(
        (map['rooms'] as List<dynamic>).map<Room>(
          (x) => Room.fromMap(x as Map<String, dynamic>),
        ),
      ),
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailableRoom.fromJson(String source) =>
      AvailableRoom.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AvailableRoom( count: $count, rooms: $rooms)';

  @override
  bool operator ==(covariant AvailableRoom other) {
    if (identical(this, other)) return true;

    return other.count == count && listEquals(other.rooms, rooms);
  }

  @override
  int get hashCode => count.hashCode ^ rooms.hashCode;
}

class Room {
  final String id;
  final String number;
  final RoomType roomType;
  Room({
    required this.id,
    required this.number,
    required this.roomType,
  });

  Room copyWith({
    String? id,
    String? number,
    RoomType? roomType,
  }) {
    return Room(
      id: id ?? this.id,
      number: number ?? this.number,
      roomType: roomType ?? this.roomType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'number': number,
      'roomType': roomType.toMap(),
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['_id'] as String,
      number: map['number'] as String,
      roomType: RoomType.fromMap(map['roomType'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Room(_id: $id, number: $number, roomType: $roomType)';

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.number == number &&
        other.roomType == roomType;
  }

  @override
  int get hashCode => id.hashCode ^ number.hashCode ^ roomType.hashCode;
}

class RoomType {
  final String id;
  final String type;
  final int rent;
  RoomType({
    required this.id,
    required this.type,
    required this.rent,
  });

  RoomType copyWith({
    String? id,
    String? type,
    int? rent,
  }) {
    return RoomType(
      id: id ?? this.id,
      type: type ?? this.type,
      rent: rent ?? this.rent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'type': type,
      'rent': rent,
    };
  }

  factory RoomType.fromMap(Map<String, dynamic> map) {
    return RoomType(
      id: map['_id'] as String,
      type: map['type'] as String,
      rent: map['rent'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomType.fromJson(String source) =>
      RoomType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RoomType(_id: $id, type: $type, rent: $rent)';

  @override
  bool operator ==(covariant RoomType other) {
    if (identical(this, other)) return true;

    return other.id == id && other.type == type && other.rent == rent;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ rent.hashCode;
}
