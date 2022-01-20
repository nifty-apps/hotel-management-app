// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:samudra_bilash_hotel/model/response/error_response.dart';
import 'package:samudra_bilash_hotel/util/app_constants.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();
  final int timeoutInSeconds = 30;
  final String noInternetMessage =
      'Connection to API server failed due to internet connection';
  String token = '3|pSadZ1dxc0kFisN5w5Y8agWHBZYF0JQVrgYPcKvh';
  Future<dynamic> get(String url) {
    Uri uri = Uri.parse(url);
    return http.get(uri).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url,
      {Map<String, String>? headers, body, encoding}) {
    Uri uri = Uri.parse(AppConstants.BASE_URL + url);
    return http
        .post(uri, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 /* || json == null */) {
        throw new Exception("Error while fetching data");
      }
      print(res);
      return _decoder.convert(res);
    });
  }

  Future<Response> bookRoom(
      {Map<String, String>? headers, body, encoding}) async {
    /* print({
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
    }); */
    /*  final Map<String, dynamic> data = {
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
    }; */
    http.Response _response = await http.post(
      Uri.parse(AppConstants.BASE_URL + AppConstants.ROOM_BOOK),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(body),
    );
    Response response = handleResponse(_response);
    print(response);
    print(response.body);
    return response;
  }

//
  Future<Response> getData(
    String uri,
  ) async {
    print('ente the get data file----------');
    print(AppConstants.BASE_URL + uri);
    try {
      print('entry to the try method');
      http.Response _response = await http.get(
        Uri.parse(AppConstants.BASE_URL + uri),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(
        Duration(seconds: timeoutInSeconds),
      );
      Response response = handleResponse(_response);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  /*  getAllRooms(String url, token)async {
    Uri uri = Uri.parse(url);
   return  http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //return response.body;
  } */
  Response handleResponse(http.Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {
      print(
        e.toString(),
      );
    }
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors[0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    return _response;
  }
}
