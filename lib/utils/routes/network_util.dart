// import 'dart:async';
// import 'dart:convert';
// import 'package:get/get_connect/http/src/response/response.dart';
// import 'package:http/http.dart' as http;
// import 'package:hotel_management/model/response/error_response.dart';
// import 'package:hotel_management/util/app_constants.dart';

// class NetworkUtil {
//   // next three lines makes this class a Singleton
//   static NetworkUtil _instance = new NetworkUtil.internal();
//   NetworkUtil.internal();
//   factory NetworkUtil() => _instance;

//   final int timeoutInSeconds = 30;
//   final String noInternetMessage =
//       'Connection to API server failed due to internet connection';
//   String token = '3|pSadZ1dxc0kFisN5w5Y8agWHBZYF0JQVrgYPcKvh';

//   Future<Response> getData(
//     String uri,
//   ) async {
//     try {
//       http.Response _response = await http.get(
//         Uri.parse(AppConstants.BASE_URL + uri),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       ).timeout(
//         Duration(seconds: timeoutInSeconds),
//       );
//       Response response = handleResponse(_response);
//       return response;
//     } catch (e) {
//       return Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }

//   Future<Response> postData(
//     String url, {
//     required Object body,
//     encoding,
//   }) async {
//     try {
//       http.Response _response = await http
//           .post(
//             Uri.parse(AppConstants.BASE_URL + url),
//             headers: {
//               'Content-Type': 'application/json',
//               'Accept': 'application/json',
//               'Authorization': 'Bearer $token',
//             },
//             body: body,
//           )
//           .timeout(
//             Duration(seconds: timeoutInSeconds),
//           );
//       Response response = handleResponse(_response);
//       return response;
//     } catch (e) {
//       return Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }

//   Response handleResponse(http.Response response) {
//     dynamic _body;
//     try {
//       _body = jsonDecode(response.body);
//     } catch (e) {
//       print(e.toString());
//     }
//     Response _response = Response(
//       body: _body != null ? _body : response.body,
//       bodyString: response.body.toString(),
//       headers: response.headers,
//       statusCode: response.statusCode,
//       statusText: response.reasonPhrase,
//     );
//     if (_response.statusCode != 200 &&
//         _response.body != null &&
//         _response.body is! String) {
//       if (_response.body.toString().startsWith('{errors: [{code:')) {
//         ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
//         _response = Response(
//             statusCode: _response.statusCode,
//             body: _response.body,
//             statusText: _errorResponse.errors[0].message);
//       } else if (_response.body.toString().startsWith('{message')) {
//         _response = Response(
//             statusCode: _response.statusCode,
//             body: _response.body,
//             statusText: _response.body['message']);
//       }
//     } else if (_response.statusCode != 200 && _response.body == null) {
//       _response = Response(statusCode: 0, statusText: noInternetMessage);
//     }
//     return _response;
//   }
// }
