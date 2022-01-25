import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somudro_bilash_hotel/model/collection_reports.dart';

import 'package:http/http.dart' as http;
import 'package:somudro_bilash_hotel/util/app_constants.dart';

final client = http.Client();

class ReportController extends GetxController {
  bool isLoading = false;
  Reports allReports = Reports();

  Future<String> getReports() async {
    isLoading = true;
    update();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("Token");
    print("Aithorization token :$token");
    http.Response response = await client.get(
      Uri.parse(AppConstants.BASE_URL + AppConstants.collectionsReport),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var result = (jsonDecode(response.body));

      allReports = Reports.fromJson(result['report']);

      print("All Reports : $allReports");
    }
    isLoading = false;
    update();
    return response.body;
  }
}