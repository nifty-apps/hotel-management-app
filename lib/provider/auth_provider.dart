import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/hotel.dart';
import 'package:hotel_management/models/user.dart';
import 'package:hotel_management/services/local_strorage.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider(this.ref);

  bool isLoading = false;
  User? userData;

  // User registration
  Future<bool> registration(String fullName, String email, String password,
      BuildContext context) async {
    try {
      final response = await ref
          .read(apiClientProvider)
          .post(AppConstants.registraionUrl, data: {
        'name': fullName,
        'email': email,
        'password': password,
        'role': 'Owner',
      });
      if (response.statusCode == 201) {
        String token = response.data['data']['token'];
        ref.read(apiClientProvider).updateToken(token);
        ref.read(localStorageProvider).saveToken(token);
        return true;
      } else {
        String message = response.data['message'];
        showSnackBarMethod(context, message, false);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  // User login
  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      final response = await ref.read(apiClientProvider).post(
        AppConstants.loginUrl,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        String? token = response.headers.map['access-token']?.first;
        userData = User.fromMap(response.data['data']);
        ref.read(apiClientProvider).updateToken(token!);
        ref.read(localStorageProvider).saveToken(token);
        ref.read(localStorageProvider).saveUser(userData!);
        return true;
      } else {
        String message = response.data['message'];
        showSnackBarMethod(context, message, false);
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  // Add Hotel
  Future<Hotel?> addHotel(
      String name, ownerName, address, contactNumber) async {
    try {
      final response = await ref.read(apiClientProvider).post(
        AppConstants.hotelAddUrl,
        data: {
          'name': name,
          'ownerName': ownerName,
          'address': address,
          'contactNumber': contactNumber,
        },
      );
      if (response.statusCode == 200) {
        final hotel = Hotel.fromMap(response.data['data']);
        final updatedUser = userData!.copyWith(
          hotel: hotel,
        );
        print(updatedUser);
        ref.read(localStorageProvider).saveUser(updatedUser);
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
    ref.read(localStorageProvider).removeTokenAndUser();
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

final authProvider = ChangeNotifierProvider((ref) => AuthProvider(ref));
// final authProvider = Provider((ref) => AuthProvider(ref));
