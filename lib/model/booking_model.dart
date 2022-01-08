class BokkingForm {
  late String _name;
  late String _phone;
  late String _address;
  late int _room_id;
  late String _check_in_date;
  late String _check_out_date;
  late String _check_in_time;
  late String _check_out_time;
  late String _booking_status;
  late int _advance_room_fare;
  late int _room_fare;
  late bool _is_paid;
  BokkingForm(
      this._name,
      this._phone,
      this._address,
      this._room_id,
      this._check_in_date,
      this._check_out_date,
      this._check_in_time,
      this._check_out_time,
      this._booking_status,
      this._advance_room_fare,
      this._room_fare,
      this._is_paid);

  BokkingForm.map(dynamic obj) {
    this._name = obj["name"];
    this._phone = obj["phone"];
    this._address = obj["address"];
    this._room_id = obj["room_id"];
    this._check_in_date = obj["check_in_date"];
    this._check_out_date = obj["check_out_date"];
    this._check_in_time = obj["check_in_time"];
    this._check_out_time = obj["check_out_time"];
    this._booking_status = obj["booking"];
    this._advance_room_fare = obj["advance_room_fare"];
    this._room_fare = obj["room_fare"];
    this._is_paid = obj["is_paid"];
  }

  String get name => _name;
  String get phone => _phone;
  String get address => _address;
  int get roomId => _room_id;
  String get checkInDate => _check_in_date;
  String get checkOutDate => _check_out_date;
  String get checkInTime => _check_in_time;
  String get checkOutTime => _check_out_time;
  String get bookingStatus => _booking_status;
  int get advanceRoomFare => _advance_room_fare;
  int get roomFare => _room_fare;
  bool get isPaid => _is_paid;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["phone"] = _phone;
    map["address"] = _address;
    map["room_id"] = _room_id;
    map["check_in_date"] = _check_in_date;
    map["check_out_date"] = _check_out_date;
    map["check_in_time"] = _check_in_time;
    map["check_out_time"] = _check_out_time;
    map["booking_status"] = _booking_status;
    map["advance_room_fare"] = _advance_room_fare;
    map["room_fare"] = _room_fare;
    map["is_paid"] = _is_paid;

    return map;
  }
}
