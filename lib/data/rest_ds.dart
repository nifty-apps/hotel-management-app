// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:somudro_bilash_hotel/model/login_response_model.dart';
import 'package:somudro_bilash_hotel/model/user.dart';
import 'package:somudro_bilash_hotel/util/app_constants.dart';
import 'package:somudro_bilash_hotel/utils/routes/network_util.dart';

class RestDatasource {
  static NetworkUtil _netUtil = new NetworkUtil();

  static String token = '';

  Future<User> login(String username, String password) {
    return _netUtil.post(AppConstants.LOGIN_URL,
        body: {"email": username, "password": password}).then((dynamic res) {
      // if (res["error"]) throw new Exception(res["error_msg"]);
      ResponseLogin loginRes = ResponseLogin.fromJson(res);
      print(loginRes);

      print(loginRes);
      return User(password, username);
      // return new ResponseLogin.map(res["user"]);
    });
  }

  ////////  booking room process
  static Future<Response> bookRoom(
    String _name,
    int _phone,
    String _address,
    int _room_id,
    String _check_in_date,
    String _check_out_date,
    String _booking_status,
    int _room_fare,
    int _paid_ammount,
  ) async {
    print({
      "name": _name,
      "phone": _phone,
      "address": _address,
      "room_id": _room_id,
      "check_in_date": _check_in_date,
      "check_out_date": _check_out_date,
      "booking_status": _booking_status,
      "paid_ammount": _paid_ammount,
      "room_fare": _room_fare,
    });
    final Map<String, dynamic> data = {
      "name": _name,
      "phone": _phone,
      "address": _address,
      "room_id": _room_id,
      "check_in_date": _check_in_date,
      "check_out_date": _check_out_date,
      "booking_status": _booking_status,
      "paid_ammount": _paid_ammount,
      "room_fare": _room_fare,
    };
    Response response = await _netUtil.bookRoom(body: data);
    //   Response response = handleResponse(response);
    print(response);
    return response;
    //  Response response = _netUtil.post(AppConstants.ROOM_BOOK, body: data);
    /* return _netUtil.post(AppConstants.ROOM_BOOK, body: {
      "name": _name,
      "phone": _phone,
      "address": _address,
      "room_id": _room_id,
      "check_in_date": _check_in_date,
      "check_out_date": _check_out_date,
      "check_in_time": _check_in_time,
      "check_out_time": _check_out_time,
      "booking_status": _booking_status,
      "advance_room_fare": _advance_room_fare,
      "room_fare": _room_fare,
      "is_paid": _is_paid
    }).then((dynamic res) {
      // if (res["error"]) throw new Exception(res["error_msg"]);
      ResponseLogin loginRes = ResponseLogin.fromJson(res);
      print(loginRes);

      print(loginRes);
      // return User(password, username);
      // return new ResponseLogin.map(res["user"]);
      return res;
    }); */
  }

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
}
