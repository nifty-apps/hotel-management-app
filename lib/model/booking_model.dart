// ignore_for_file: non_constant_identifier_names

class BookingForm {
  late String _name;
  late String _phone;
  late String _address;
  late int _room_id;
  late String _check_in_date;
  late String _check_out_date;
  late String _booking_status;
  late int _paid_ammount;
  late int _room_fare;

  BookingForm(
    this._name,
    this._phone,
    this._address,
    this._room_id,
    this._check_in_date,
    this._check_out_date,
    this._booking_status,
    this._paid_ammount,
    this._room_fare,
  );

  BookingForm.map(dynamic obj) {
    this._name = obj["name"];
    this._phone = obj["phone"];
    this._address = obj["address"];
    this._room_id = obj["room_id"];
    this._check_in_date = obj["check_in_date"];
    this._check_out_date = obj["check_out_date"];
    this._booking_status = obj["booking"];
    this._paid_ammount = obj["paid_ammount"];
    this._room_fare = obj["room_fare"];
  }

  String get name => _name;
  String get phone => _phone;
  String get address => _address;
  int get roomId => _room_id;
  String get checkInDate => _check_in_date;
  String get checkOutDate => _check_out_date;
  String get bookingStatus => _booking_status;
  int get paidAmmount => _paid_ammount;
  int get roomFare => _room_fare;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["phone"] = _phone;
    map["address"] = _address;
    map["room_id"] = _room_id;
    map["check_in_date"] = _check_in_date;
    map["check_out_date"] = _check_out_date;
    map["booking_status"] = _booking_status;
    map["paid_ammount"] = _paid_ammount;

    map["room_fare"] = _room_fare;

    return map;
  }
}
