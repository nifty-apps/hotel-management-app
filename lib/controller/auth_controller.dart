import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:somudro_bilash_hotel/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  Future<bool> login(String email, password) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.LOGIN_URL),
          body: {
            "email": email,
            "password": password,
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(
          response.body.toString(),
        );
        //save token in sharedPreferences
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString("Token", data["token"]);

        print(data["token"]);
        print("Login successful");
        update();
        return true;
      } else {
        print("Field");
        return false;
      }
    } catch (e) {
      print(
        e.toString(),
      );
      return false;
    }
  }

  Future<bool> logout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("Token");
    print("Logout Successful");
    update();
    return true;
  }
}
