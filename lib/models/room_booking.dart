import 'dart:convert';

import 'package:flutter/foundation.dart';

class RoomBooking {
  final Customer customer;
  final List<String> rooms;
  final String checkIn;
  final String checkOut;
  final int total;
  final int discount;
  final String status;
  RoomBooking({
    required this.customer,
    required this.rooms,
    required this.checkIn,
    required this.checkOut,
    required this.total,
    required this.discount,
    required this.status,
  });

  RoomBooking copyWith({
    Customer? customer,
    List<String>? rooms,
    String? checkIn,
    String? checkOut,
    int? total,
    int? discount,
    String? status,
  }) {
    return RoomBooking(
      customer: customer ?? this.customer,
      rooms: rooms ?? this.rooms,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      total: total ?? this.total,
      discount: discount ?? this.discount,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customer': customer.toMap(),
      'rooms': rooms,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'total': total,
      'discount': discount,
      'status': status,
    };
  }

  factory RoomBooking.fromMap(Map<String, dynamic> map) {
    return RoomBooking(
      customer: Customer.fromMap(map['customer'] as Map<String, dynamic>),
      rooms: List<String>.from((map['rooms'] as List<String>)),
      checkIn: map['checkIn'] as String,
      checkOut: map['checkOut'] as String,
      total: map['total'].toInt() as int,
      discount: map['discount'].toInt() as int,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomBooking.fromJson(String source) =>
      RoomBooking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomBooking(customer: $customer, rooms: $rooms, checkIn: $checkIn, checkOut: $checkOut, total: $total, discount: $discount, status: $status)';
  }

  @override
  bool operator ==(covariant RoomBooking other) {
    if (identical(this, other)) return true;

    return other.customer == customer &&
        listEquals(other.rooms, rooms) &&
        other.checkIn == checkIn &&
        other.checkOut == checkOut &&
        other.total == total &&
        other.discount == discount &&
        other.status == status;
  }

  @override
  int get hashCode {
    return customer.hashCode ^
        rooms.hashCode ^
        checkIn.hashCode ^
        checkOut.hashCode ^
        total.hashCode ^
        discount.hashCode ^
        status.hashCode;
  }
}

class Customer {
  final String name;
  final String phone;
  Customer({
    required this.name,
    required this.phone,
  });

  Customer copyWith({
    String? name,
    String? phone,
  }) {
    return Customer(
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Customer(name: $name, phone: $phone)';

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.name == name && other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode;
}
