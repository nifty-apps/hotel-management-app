import 'dart:convert';

class RoomType {
  int id;
  String name;
  int totalRooms;
  RoomType({
    required this.id,
    required this.name,
    required this.totalRooms,
  });

  RoomType copyWith({
    int? id,
    String? name,
    int? totalRooms,
  }) {
    return RoomType(
      id: id ?? this.id,
      name: name ?? this.name,
      totalRooms: totalRooms ?? this.totalRooms,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalRooms': totalRooms,
    };
  }

  factory RoomType.fromMap(Map<String, dynamic> map) {
    return RoomType(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      totalRooms: map['totalRooms']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomType.fromJson(String source) =>
      RoomType.fromMap(json.decode(source));

  @override
  String toString() =>
      'RoomType(id: $id, name: $name, totalRooms: $totalRooms)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomType &&
        other.id == id &&
        other.name == name &&
        other.totalRooms == totalRooms;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ totalRooms.hashCode;
}
