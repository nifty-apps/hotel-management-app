import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_management/models/hotel.dart';
import 'package:hotel_management/models/registration.dart';
import 'package:hotel_management/models/user.dart';
import 'package:hotel_management/services/local_strorage.dart';
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
  late User userData;

  // User registration
  Future<bool> registration(
      RegistrationModel userData, BuildContext context) async {
    try {
      final response = await _apiClient.post(AppConstants.registraionUrl,
          data: userData.toJson());
      if (response.statusCode == 201) {
        String token = response.data['data']['token'];
        _apiClient.updateToken(token);
        Get.find<LocalStorage>().saveToken(token);
        return true;
      }
      {
        print(response.data['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data['message']),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  // User login
  Future<bool> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await _apiClient.post(
        AppConstants.loginUrl,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        String? token = response.headers.map['access-token']?.first;
        userData = User.fromMap(response.data['data']);
        _apiClient.updateToken(token!);
        Get.find<LocalStorage>().saveToken(token);
        Get.find<LocalStorage>().saveUser(userData);
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data['message']),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  // Add Hotel
  Future<Hotel?> addHotel(String name, address) async {
    try {
      final response = await _apiClient.post(
        AppConstants.hotelAddUrl,
        data: {
          'name': name,
          'address': address,
        },
      );
      if (response.statusCode == 200) {
        final hotel = Hotel.fromMap(response.data['data']);
        final updatedUser = Get.find<AuthController>().userData.copyWith(
              hotel: hotel,
            );
        await Get.find<LocalStorage>().saveUser(updatedUser);
        return hotel;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // User logout
  Future<bool> logout() async {
    Get.find<LocalStorage>().removeTokenAndUser();
    update();
    return true;
  }

  // User get profile
  Future<User?> getUserProfile() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token");
    http.Response response = await http.get(
        Uri.parse(AppConstants.baseUrl + AppConstants.adminProfile),
        headers: {
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return User.fromJson(result['data']);
    }
    return null;
  }
}
