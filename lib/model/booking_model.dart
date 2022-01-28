import 'dart:convert';

class Booking {
  final int bookingId;
  final String customerName;
  final String customerPhone;
  final String bookingStatus;
  final String fromDate;
  final String toDate;
  Booking({
    required this.bookingId,
    required this.customerName,
    required this.customerPhone,
    required this.bookingStatus,
    required this.fromDate,
    required this.toDate,
  });

  Booking copyWith({
    int? bookingId,
    String? customerName,
    String? customerPhone,
    String? bookingStatus,
    String? fromDate,
    String? toDate,
  }) {
    return Booking(
      bookingId: bookingId ?? this.bookingId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'bookingStatus': bookingStatus,
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      bookingId: map['bookingId']?.toInt() ?? 0,
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      bookingStatus: map['bookingStatus'] ?? '',
      fromDate: map['fromDate'] ?? '',
      toDate: map['toDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Booking(bookingId: $bookingId, customerName: $customerName, customerPhone: $customerPhone, bookingStatus: $bookingStatus, fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Booking &&
        other.bookingId == bookingId &&
        other.customerName == customerName &&
        other.customerPhone == customerPhone &&
        other.bookingStatus == bookingStatus &&
        other.fromDate == fromDate &&
        other.toDate == toDate;
  }

  @override
  int get hashCode {
    return bookingId.hashCode ^
        customerName.hashCode ^
        customerPhone.hashCode ^
        bookingStatus.hashCode ^
        fromDate.hashCode ^
        toDate.hashCode;
  }
}
