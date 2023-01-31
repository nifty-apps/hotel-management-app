import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_management/model/body/registration.dart';
import 'package:hotel_management/model/user_model.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pasController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  bool isLoading = false;

  // User registration
  Future<bool> registration(
      RegistrationModel userData, BuildContext context) async {
    try {
      final response = await _apiClient.post(AppConstants.registraionUrl,
          data: userData.toJson());
      if (response.statusCode == 201) {
        String token = response.data['data']['token'];
        _apiClient.updateToken(token);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('Token', token);
        return true;
      } else if (response.statusCode == 403) {
        print(response.data['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data['message']),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // User login
  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      final response = await _apiClient.post(AppConstants.loginUrl,
          data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        String? token = response.headers.map['access-token']?.first;
        print(token);
        _apiClient.updateToken(token!);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('Token', token);
        return true;
      } else if (response.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data['message']),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
        return false;
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
