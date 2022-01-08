import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:samudra_bilash_hotel/data/rest_ds.dart';

class BookingController extends GetxController implements GetxService {
  String name = "Mohammad Ali";
  int phone = 01826078348;
  String address = "Pearabag Moghbazar";
  int roomId = 12;
  String checkInDate = "2021-12-16";
  String checkOutDate = "2021-12-24";
  String checkInTime = "10:00";
  String checkOutTime = "04:00";
  String bookingStatus = "booked";
  int advanceRoomFare = 2000;
  int roomFare = 4000;
  int isPaid = 0;

  /* String get name => _name;
  int get phone => _phone;
  String get address => _address;
  int get roomId => _room_id;
  String get checkInDate => _check_in_date;
  String get checkOutDate => _check_out_date;
  String get checkInTime => _check_in_time;
  String get checkOutTime => _check_out_time;
  String get bookingStatus => _booking_status;
  int get advanceRoomFare => _advance_room_fare;
  int get roomFare => _room_fare;
  int get isPaid => _is_paid; */

  Future<void> bookRoom() async {
    Response response = await RestDatasource.bookRoom(
      name,
      phone,
      address,
      roomId,
      checkInDate,
      checkOutDate,
      checkInTime,
      checkOutTime,
      bookingStatus,
      advanceRoomFare,
      roomFare,
      isPaid,
    );
    print(response);
  }
}
