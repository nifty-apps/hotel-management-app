import 'dart:convert';

import 'package:flutter/foundation.dart';

class HotelRevenue {
  final int totalAmount;
  final List<RevenueHistory> transactions;
  HotelRevenue({
    required this.totalAmount,
    required this.transactions,
  });

  HotelRevenue copyWith({
    int? totalAmount,
    List<RevenueHistory>? transactions,
  }) {
    return HotelRevenue(
      totalAmount: totalAmount ?? this.totalAmount,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalAmount': totalAmount,
      'transactions': transactions.map((x) => x.toMap()).toList(),
    };
  }

  factory HotelRevenue.fromMap(Map<String, dynamic> map) {
    return HotelRevenue(
      totalAmount: map['totalAmount'].toInt() as int,
      transactions: List<RevenueHistory>.from(
        (map['transactions'] as List<dynamic>).map<RevenueHistory>(
          (x) => RevenueHistory.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelRevenue.fromJson(String source) =>
      HotelRevenue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HotelRevenue(totalAmount: $totalAmount, transactions: $transactions)';

  @override
  bool operator ==(covariant HotelRevenue other) {
    if (identical(this, other)) return true;

    return other.totalAmount == totalAmount &&
        listEquals(other.transactions, transactions);
  }

  @override
  int get hashCode => totalAmount.hashCode ^ transactions.hashCode;
}

class RevenueHistory {
  final String id;
  final int amount;
  final String paymentMethod;
  final String booking;
  final DateTime createdAt;
  RevenueHistory({
    required this.id,
    required this.amount,
    required this.paymentMethod,
    required this.booking,
    required this.createdAt,
  });

  RevenueHistory copyWith({
    String? id,
    int? amount,
    String? paymentMethod,
    String? booking,
    DateTime? createdAt,
  }) {
    return RevenueHistory(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      booking: booking ?? this.booking,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'booking': booking,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RevenueHistory.fromMap(Map<String, dynamic> map) {
    return RevenueHistory(
      id: map['_id'] as String,
      amount: map['amount'].toInt() as int,
      paymentMethod: map['paymentMethod'] as String,
      booking: map['booking'] as String,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RevenueHistory.fromJson(String source) =>
      RevenueHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RevenueHistory(_id: $id, amount: $amount, paymentMethod: $paymentMethod, booking: $booking)';
  }

  @override
  bool operator ==(covariant RevenueHistory other) {
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
