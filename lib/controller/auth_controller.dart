import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:somudro_bilash_hotel/model/user_model.dart';
import 'package:somudro_bilash_hotel/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  bool isLoading = false;
  Future<bool> login(String email, password) async {
    isLoading = true;
    update();
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.LOGIN_URL),
          body: {
            'email': email,
            'password': password,
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(
          response.body.toString(),
        );
        //save token in sharedPreferences
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('Token', data['token']);
        isLoading = false;
        update();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> logout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('Token');
    update();
    return true;
  }

  Future<User?> getUserProfile() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("Token");
    http.Response response = await http.get(
        Uri.parse(AppConstants.BASE_URL + AppConstants.adminProfile),
        headers: {
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return User.fromMap(result['data']);
    }
  }
}
