import 'dart:async';
import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:somudro_bilash_hotel/util/app_constants.dart';
import 'package:somudro_bilash_hotel/utils/routes/network_util.dart';

class RestDatasource {
  static NetworkUtil _netUtil = new NetworkUtil();

  static Future<Response> getAllRooms() async {
    return await _netUtil.getData(
      AppConstants.TOTAL_ROOM,
    );
  }

  static Future<Response> searchRooms(String startDate, String endDate) async {
    return await _netUtil.getData(
      '${AppConstants.SEARCH_ROOM}?check_in_date=$startDate&check_out_date=$endDate',
    );
  }

  // booking room process
  static Future<Response> bookRoom(
    String _name,
    int _phone,
    String _address,
    int _roomId,
    String _checkInDate,
    String _checkOutDate,
    String _bookingStatus,
    int _roomFare,
    int _paidAmount,
  ) async {
    final Map<String, dynamic> data = {
      'name': _name,
      'phone': _phone,
      'address': _address,
      'room_id': _roomId,
      'check_in_date': _checkInDate,
      'check_out_date': _checkOutDate,
      'booking_status': _bookingStatus,
      'paid_amount': _paidAmount,
      'room_fare': _roomFare,
    };
    print('Booking data: $data');

    Response response = await _netUtil.postData(
      AppConstants.ROOM_BOOK,
      body: jsonEncode(data),
    );
    return response;
  }
}
