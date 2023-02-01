import 'dart:convert';

class Booking {
  int? id;
  int? roomId;
  String name;
  String phone;
  String? address;
  String bookingStatus;
  int roomFare;
  int paidAmount;
  DateTime checkInDate;
  DateTime checkOutDate;
  Booking({
    this.id,
    this.roomId,
    required this.name,
    required this.phone,
    required this.address,
    required this.bookingStatus,
    required this.roomFare,
    required this.paidAmount,
    required this.checkInDate,
    required this.checkOutDate,
  });

  Booking copyWith({
    int? id,
    int? roomId,
    String? name,
    String? phone,
    String? address,
    String? bookingStatus,
    int? roomFare,
    int? paidAmount,
    DateTime? checkInDate,
    DateTime? checkOutDate,
  }) {
    return Booking(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      roomFare: roomFare ?? this.roomFare,
      paidAmount: paidAmount ?? this.paidAmount,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': roomId,
      'name': name,
      'phone': phone,
      'address': address,
      'booking_status': bookingStatus,
      'room_fare': roomFare,
      'paid_amount': paidAmount,
      'check_in_date': checkInDate.toIso8601String(),
      'check_out_date': checkOutDate.toIso8601String(),
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id']?.toInt(),
      roomId: map['room_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      bookingStatus: map['booking_status'] ?? '',
      roomFare: map['room_fare']?.toInt() ?? 0,
      paidAmount: map['paid_amount']?.toInt() ?? 0,
      checkInDate: DateTime.parse(map['check_in_date']),
      checkOutDate: DateTime.parse(map['check_out_date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Booking(id: $id, roomId: $roomId, name: $name, phone: $phone, address: $address, bookingStatus: $bookingStatus, roomFare: $roomFare, paidAmount: $paidAmount, checkInDate: $checkInDate, checkOutDate: $checkOutDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Booking &&
        other.id == id &&
        other.roomId == roomId &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.bookingStatus == bookingStatus &&
        other.roomFare == roomFare &&
        other.paidAmount == paidAmount &&
        other.checkInDate == checkInDate &&
        other.checkOutDate == checkOutDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roomId.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        bookingStatus.hashCode ^
        roomFare.hashCode ^
        paidAmount.hashCode ^
        checkInDate.hashCode ^
        checkOutDate.hashCode;
  }
}
