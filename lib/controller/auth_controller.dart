import 'dart:convert';

import 'package:get/get.dart';
import 'package:hotel_management/model/user_model.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  bool isLoading = false;

  // User login
  Future<bool> login(String email, String password) async {
    try {
      final response = await _apiClient.post(AppConstants.loginUrl,
          data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  // User logout
  Future<bool> logout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('Token');
    update();
    return true;
  }

  // User get profile
  Future<User?> getUserProfile() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("Token");
    http.Response response = await http.get(
        Uri.parse(AppConstants.baseUrl + AppConstants.adminProfile),
        headers: {
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return User.fromMap(result['data']);
    }
    return null;
  }
}
