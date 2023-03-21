import 'dart:convert';

import 'package:hotel_management/models/hotel.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String role;
  final Hotel? hotel;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.hotel,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    Hotel? hotel,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      hotel: hotel ?? this.hotel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'hotel': hotel?.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'],
      role: map['role'] as String,
      hotel: map['hotel'] != null
          ? Hotel.fromMap(map['hotel'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phone, role: $role, hotel: $hotel)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.role == role &&
        other.hotel == hotel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        role.hashCode ^
        hotel.hashCode;
  }
}
