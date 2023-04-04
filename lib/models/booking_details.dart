import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hotel_management/models/available_room.dart';

class BookingDetails {
  final String id;
  final Customer customer;
  final List<Room> rooms;
  final DateTime checkIn;
  final DateTime checkOut;
  final String status;
  final String paymentStatus;
  final int total;
  final int discount;
  BookingDetails({
    required this.id,
    required this.customer,
    required this.rooms,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.paymentStatus,
    required this.total,
    required this.discount,
  });

  BookingDetails copyWith({
    String? id,
    Customer? customer,
    List<Room>? rooms,
    DateTime? checkIn,
    DateTime? checkOut,
    String? status,
    String? paymentStatus,
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
      paymentStatus: paymentStatus ?? this.paymentStatus,
      total: total ?? this.total,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'customer': customer.toMap(),
      'rooms': rooms.map((x) => x.toMap()).toList(),
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'status': status,
      'paymentStatus': paymentStatus,
      'total': total,
      'discount': discount,
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
      checkIn: DateTime.parse(map['checkIn']),
      checkOut: DateTime.parse(map['checkOut']),
      status: map['status'] as String,
      paymentStatus: map['paymentStatus'] as String,
      total: map['total'].toInt() as int,
      discount: map['discount'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingDetails.fromJson(String source) =>
      BookingDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingDetails(_id: $id, customer: $customer, rooms: $rooms, checkIn: $checkIn, checkOut: $checkOut, status: $status, paymentStatus:$paymentStatus,  total: $total, discount: $discount)';
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
        other.discount == discount;
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
        discount.hashCode;
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
    String? id,
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
  String toString() => 'Customer(name: $name, phone: $phone, )';

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.name == name && other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode;
}
