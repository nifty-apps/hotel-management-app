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
    int? count,
    List<Room>? rooms,
    String? type,
  }) {
    return AvailableRoom(
      count: count ?? this.count,
      rooms: rooms ?? this.rooms,
      type: type ?? this.type,
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
  String toString() =>
      'AvailableRoom(count: $count, rooms: $rooms, type: $type)';

  @override
  bool operator ==(covariant AvailableRoom other) {
    if (identical(this, other)) return true;

    return other.count == count &&
        listEquals(other.rooms, rooms) &&
        other.type == type;
  }

  @override
  int get hashCode => count.hashCode ^ rooms.hashCode ^ type.hashCode;
}

class Room {
  final String id;
  final String number;
  final int rent;
  Room({
    required this.id,
    required this.number,
    required this.rent,
  });

  Room copyWith({
    String? id,
    String? number,
    int? rent,
  }) {
    return Room(
      id: id ?? this.id,
      number: number ?? this.number,
      rent: rent ?? this.rent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'number': number,
      'rent': rent,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['_id'] as String,
      number: map['number'] as String,
      rent: map['rent'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Room(id: $id, number: $number, rent: $rent)';

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.id == id && other.number == number && other.rent == rent;
  }

  @override
  int get hashCode => id.hashCode ^ number.hashCode ^ rent.hashCode;
}
