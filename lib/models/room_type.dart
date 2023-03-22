// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RoomType {
  String id;
  String type;
  int rent;
  String description;
  RoomType({
    required this.id,
    required this.type,
    required this.rent,
    required this.description,
  });

  RoomType copyWith({
    String? id,
    String? type,
    int? rent,
    String? description,
  }) {
    return RoomType(
      id: id ?? this.id,
      type: type ?? this.type,
      rent: rent ?? this.rent,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'type': type,
      'rent': rent,
      'description': description,
    };
  }

  factory RoomType.fromMap(Map<String, dynamic> map) {
    return RoomType(
        id: map['_id'] as String,
        type: map['roomType'] as String,
        rent: map['rent'],
        description: map['description']);
  }

  String toJson() => json.encode(toMap());

  factory RoomType.fromJson(String source) =>
      RoomType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomType(id: $id, type: $type, rent: $rent, description: $description)';
  }

  @override
  bool operator ==(covariant RoomType other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.rent == rent &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^ type.hashCode ^ rent.hashCode ^ description.hashCode;
  }
}
