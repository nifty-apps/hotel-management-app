import 'dart:convert';

class CustomerInfo {
  final String bookingId;
  final Customer customer;
  CustomerInfo({
    required this.bookingId,
    required this.customer,
  });

  CustomerInfo copyWith({
    String? bookingId,
    Customer? customer,
  }) {
    return CustomerInfo(
      bookingId: bookingId ?? this.bookingId,
      customer: customer ?? this.customer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': bookingId,
      'customer': customer.toMap(),
    };
  }

  factory CustomerInfo.fromMap(Map<String, dynamic> map) {
    return CustomerInfo(
      bookingId: map['_id'] as String,
      customer: Customer.fromMap(map['customer'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerInfo.fromJson(String source) => CustomerInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CustomerInfo(bookingId: $bookingId, customer: $customer)';

  @override
  bool operator ==(covariant CustomerInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.bookingId == bookingId &&
      other.customer == customer;
  }

  @override
  int get hashCode => bookingId.hashCode ^ customer.hashCode;
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

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Customer(name: $name, phone: $phone)';

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode;
}