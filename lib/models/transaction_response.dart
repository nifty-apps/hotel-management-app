import 'dart:convert';

class Transaction {
  int? bookingId;
  String? adminName;
  String? roomName;
  int? roomNumber;
  int? amount;
  int? totalFare;
  String? collectionDate;
  Transaction({
    this.bookingId,
    this.adminName,
    this.roomName,
    this.roomNumber,
    this.amount,
    this.totalFare,
    this.collectionDate,
  });

  Transaction copyWith({
    int? bookingId,
    String? adminName,
    String? roomName,
    int? roomNumber,
    int? amount,
    int? totalFare,
    String? collectionDate,
  }) {
    return Transaction(
      bookingId: bookingId ?? this.bookingId,
      adminName: adminName ?? this.adminName,
      roomName: roomName ?? this.roomName,
      roomNumber: roomNumber ?? this.roomNumber,
      amount: amount ?? this.amount,
      totalFare: totalFare ?? this.totalFare,
      collectionDate: collectionDate ?? this.collectionDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'booking_id': bookingId,
      'admin_name': adminName,
      'room_name': roomName,
      'room_number': roomNumber,
      'amount': amount,
      'total_fare': totalFare,
      'collection_date': collectionDate,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      bookingId: map['booking_id']?.toInt(),
      adminName: map['admin_name'],
      roomName: map['room_name'],
      roomNumber: map['room_number']?.toInt(),
      amount: map['amount']?.toInt(),
      totalFare: map['total_fare']?.toInt(),
      collectionDate: map['collection_date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transaction(bookingId: $bookingId, adminName: $adminName, roomName: $roomName, roomNumber: $roomNumber, amount: $amount, totalFare: $totalFare, collectionDate: $collectionDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction &&
        other.bookingId == bookingId &&
        other.adminName == adminName &&
        other.roomName == roomName &&
        other.roomNumber == roomNumber &&
        other.amount == amount &&
        other.totalFare == totalFare &&
        other.collectionDate == collectionDate;
  }

  @override
  int get hashCode {
    return bookingId.hashCode ^
        adminName.hashCode ^
        roomName.hashCode ^
        roomNumber.hashCode ^
        amount.hashCode ^
        totalFare.hashCode ^
        collectionDate.hashCode;
  }
}
