import 'dart:async';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:samudra_bilash_hotel/model/login_response_model.dart';
import 'package:samudra_bilash_hotel/model/rooms_model.dart';
import 'package:samudra_bilash_hotel/model/user.dart';
import 'package:samudra_bilash_hotel/util/app_constants.dart';
import 'package:samudra_bilash_hotel/utils/routes/network_util.dart';
import 'package:http/http.dart' as http;

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

  static Future<Response> bookRoom(
    String _name,
    int _phone,
    String _address,
    int _room_id,
    String _check_in_date,
    String _check_out_date,
    String _check_in_time,
    String _check_out_time,
    String _booking_status,
    int _advance_room_fare,
    int _room_fare,
    int _is_paid,
  )async{
    print({
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
    });
    final Map<String, dynamic> data = {
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
    };
     Response response = await  _netUtil.bookRoom(
        body: data);
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
}
