import 'dart:convert';

class RecentBooking {
  final String id;
  final Customer customer;
  RecentBooking({
    required this.id,
    required this.customer,
  });

  RecentBooking copyWith({
    String? id,
    Customer? customer,
  }) {
    return RecentBooking(
      id: id ?? this.id,
      customer: customer ?? this.customer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'customer': customer.toMap(),
    };
  }

  factory RecentBooking.fromMap(Map<String, dynamic> map) {
    return RecentBooking(
      id: map['_id'] as String,
      customer: Customer.fromMap(map['customer'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentBooking.fromJson(String source) => RecentBooking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RecentBooking(_id: $id, customer: $customer)';

  @override
  bool operator ==(covariant RecentBooking other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.customer == customer;
  }

  @override
  int get hashCode => id.hashCode ^ customer.hashCode;
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