import 'dart:convert';

class Transaction {
  final String id;
  final int amount;
  final String paymentMethod;
  Transaction({
    required this.id,
    required this.amount,
    required this.paymentMethod,
  });

  Transaction copyWith({
    String? id,
    int? amount,
    String? paymentMethod,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'amount': amount,
      'paymentMethod': paymentMethod,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['_id'] as String,
      amount: map['amount'].toInt() as int,
      paymentMethod: map['paymentMethod'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Transaction(_id: $id, amount: $amount, paymentMethod: $paymentMethod)';

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.paymentMethod == paymentMethod;
  }

  @override
  int get hashCode => id.hashCode ^ amount.hashCode ^ paymentMethod.hashCode;
}
