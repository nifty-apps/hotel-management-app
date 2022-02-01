import 'dart:async';
import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:somudro_bilash_hotel/model/booking_model.dart';
import 'package:somudro_bilash_hotel/util/app_constants.dart';
import 'package:somudro_bilash_hotel/utils/routes/network_util.dart';

class RestDatasource {
  static NetworkUtil _netUtil = new NetworkUtil();

  static Future<Response> getRoomTypeInfo(
      String startDate, String endDate) async {
    return await _netUtil.getData(
      '${AppConstants.roomTypeInfo}?check_in_date=$startDate&check_out_date=$endDate',
    );
  }

  static Future<Response> getRooms(
    int roomTypeId,
    String startDate,
    String endDate,
  ) async {
    return await _netUtil.getData(
      '${AppConstants.getRooms}?check_in_date=$startDate&check_out_date=$endDate&room_type_id=$roomTypeId',
    );
  }

  static Future<Response> getBookingDetails(int roomId) async {
    return await _netUtil.getData(
      '${AppConstants.getBookingDetails}?room_id=$roomId',
    );
  }

  static Future<Response> searchRooms(String startDate, String endDate) async {
    return await _netUtil.getData(
      '${AppConstants.SEARCH_ROOM}?check_in_date=$startDate&check_out_date=$endDate',
    );
  }

  // booking room process
  static Future<Response> bookRoom(Booking booking) async {
    final Map<String, dynamic> data = booking.toMap();
    Response response = await _netUtil.postData(
      AppConstants.ROOM_BOOK,
      body: jsonEncode(data),
    );
    return response;
  }
}
