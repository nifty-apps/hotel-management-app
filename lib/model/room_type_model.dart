import 'dart:convert';
import 'package:flutter/foundation.dart';

class RoomType {
  int id;
  String name;
  int totalRooms;
  List<String> floors;
  RoomType({
    required this.id,
    required this.name,
    required this.totalRooms,
    required this.floors,
  });

  RoomType copyWith({
    int? id,
    String? name,
    int? totalRooms,
    List<String>? floors,
  }) {
    return RoomType(
      id: id ?? this.id,
      name: name ?? this.name,
      totalRooms: totalRooms ?? this.totalRooms,
      floors: floors ?? this.floors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalRooms': totalRooms,
      'floors': floors,
    };
  }

  factory RoomType.fromMap(Map<String, dynamic> map) {
    return RoomType(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      totalRooms: map['totalRooms']?.toInt() ?? 0,
      floors: List<String>.from(map['floors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomType.fromJson(String source) =>
      RoomType.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomType(id: $id, name: $name, totalRooms: $totalRooms, floors: $floors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomType &&
        other.id == id &&
        other.name == name &&
        other.totalRooms == totalRooms &&
        listEquals(other.floors, floors);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ totalRooms.hashCode ^ floors.hashCode;
  }
}
