import 'dart:convert';

class Booking {
  final Customer customer;
  final int rent;
  final DateTime checkIn;
  final DateTime checkOut;
  final dynamic room;
  Booking({
    required this.customer,
    required this.rent,
    required this.checkIn,
    required this.checkOut,
    required this.room,
  });

  Booking copyWith({
    Customer? customer,
    int? rent,
    DateTime? checkIn,
    DateTime? checkOut,
    dynamic room,
  }) {
    return Booking(
      customer: customer ?? this.customer,
      rent: rent ?? this.rent,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      room: room ?? this.room,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customer': customer.toMap(),
      'rent': rent,
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'room': room,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      customer: Customer.fromMap(map['customer'] as Map<String, dynamic>),
      rent: map['rent'] as int,
      checkIn: DateTime.parse(map['checkIn']),
      checkOut: DateTime.parse(map['checkOut']),
      room: map['room'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Booking(customer: $customer, rent: $rent, checkIn: $checkIn, checkOut: $checkOut, room: $room)';
  }

  @override
  bool operator ==(covariant Booking other) {
    if (identical(this, other)) return true;

    return other.customer == customer &&
        other.rent == rent &&
        other.checkIn == checkIn &&
        other.checkOut == checkOut &&
        other.room == room;
  }

  @override
  int get hashCode {
    return customer.hashCode ^
        rent.hashCode ^
        checkIn.hashCode ^
        checkOut.hashCode ^
        room.hashCode;
  }
}

class Customer {
  final String name;
  final String phone;
  final String address;
  Customer({
    required this.name,
    required this.phone,
    required this.address,
  });

  Customer copyWith({
    String? name,
    String? phone,
    String? address,
  }) {
    return Customer(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'address': address,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Customer(name: $name, phone: $phone, address: $address)';

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.address == address;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode ^ address.hashCode;
}
