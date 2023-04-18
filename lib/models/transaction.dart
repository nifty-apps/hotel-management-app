import 'dart:convert';

class Transaction {
  final String id;
  final int amount;
  final String paymentMethod;
  final Booking booking;
  Transaction({
    required this.id,
    required this.amount,
    required this.paymentMethod,
    required this.booking,
  });

  Transaction copyWith({
    String? id,
    int? amount,
    String? paymentMethod,
    Booking? booking,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      booking: booking ?? this.booking,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'booking': booking.toMap(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['_id'] as String,
      amount: map['amount'].toInt() as int,
      paymentMethod: map['paymentMethod'] as String,
      booking: Booking.fromMap(map['booking'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(_id: $id, amount: $amount, paymentMethod: $paymentMethod, booking: $booking)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.paymentMethod == paymentMethod &&
        other.booking == booking;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        paymentMethod.hashCode ^
        booking.hashCode;
  }
}

class Booking {
  final String id;
  final Customer customer;
  Booking({
    required this.id,
    required this.customer,
  });

  Booking copyWith({
    String? id,
    Customer? customer,
  }) {
    return Booking(
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

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['_id'] as String,
      customer: Customer.fromMap(map['customer'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Booking(_id: $id, customer: $customer)';

  @override
  bool operator ==(covariant Booking other) {
    if (identical(this, other)) return true;

    return other.id == id && other.customer == customer;
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
