// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  bool success;
  String token;
  String message;
  ResponseLogin({
    required this.success,
    required this.token,
    required this.message,
  });
  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        success: json['success'],
        token: json['token'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'token': token,
        'message': message,
      };
}
