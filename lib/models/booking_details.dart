import 'dart:convert';

import 'package:flutter/foundation.dart';

class BookingDetails {
  final String id;
  final Customer customer;
  final List<Room> rooms;
  final String checkIn;
  final String checkOut;
  final String status;
  final int total;
  final int discount;
  final String hotel;
  BookingDetails({
    required this.id,
    required this.customer,
    required this.rooms,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.total,
    required this.discount,
    required this.hotel,
  });

  BookingDetails copyWith({
    String? id,
    Customer? customer,
    List<Room>? rooms,
    String? checkIn,
    String? checkOut,
    String? status,
    int? total,
    int? discount,
    String? hotel,
  }) {
    return BookingDetails(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      rooms: rooms ?? this.rooms,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      status: status ?? this.status,
      total: total ?? this.total,
      discount: discount ?? this.discount,
      hotel: hotel ?? this.hotel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'customer': customer.toMap(),
      'rooms': rooms.map((x) => x.toMap()).toList(),
      'checkIn': checkIn,
      'checkOut': checkOut,
      'status': status,
      'total': total,
      'discount': discount,
      'hotel': hotel,
    };
  }

  factory BookingDetails.fromMap(Map<String, dynamic> map) {
    return BookingDetails(
      id: map['_id'] as String,
      customer: Customer.fromMap(map['customer'] as Map<String, dynamic>),
      rooms: List<Room>.from(
        (map['rooms'] as List<dynamic>).map<Room>(
          (x) => Room.fromMap(x as Map<String, dynamic>),
        ),
      ),
      checkIn: map['checkIn'] as String,
      checkOut: map['checkOut'] as String,
      status: map['status'] as String,
      total: map['total'].toInt() as int,
      discount: map['discount'].toInt() as int,
      hotel: map['hotel'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingDetails.fromJson(String source) =>
      BookingDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingDetails(_id: $id, customer: $customer, rooms: $rooms, checkIn: $checkIn, checkOut: $checkOut, status: $status, total: $total, discount: $discount, hotel: $hotel)';
  }

  @override
  bool operator ==(covariant BookingDetails other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customer == customer &&
        listEquals(other.rooms, rooms) &&
        other.checkIn == checkIn &&
        other.checkOut == checkOut &&
        other.status == status &&
        other.total == total &&
        other.discount == discount &&
        other.hotel == hotel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customer.hashCode ^
        rooms.hashCode ^
        checkIn.hashCode ^
        checkOut.hashCode ^
        status.hashCode ^
        total.hashCode ^
        discount.hashCode ^
        hotel.hashCode;
  }
}

class Customer {
  final String name;
  final String phone;
  final String id;
  Customer({
    required this.name,
    required this.phone,
    required this.id,
  });

  Customer copyWith({
    String? name,
    String? phone,
    String? id,
  }) {
    return Customer(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      '_id': id,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'] as String,
      phone: map['phone'] as String,
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Customer(name: $name, phone: $phone, _id: $id)';

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.name == name && other.phone == phone && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode ^ id.hashCode;
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
