import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somudro_bilash_hotel/model/response/transaction_response.dart';
import 'package:somudro_bilash_hotel/util/app_constants.dart';

class TransactionController extends GetxController implements GetxService {
  final client = http.Client();
  List<Transaction> allTransaction = [];
  bool isLoading = false;
  Future<String> getTransactions(int id) async {
    isLoading = true;
    update();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("Token");
    http.Response response = await client.get(
      Uri.parse(AppConstants.BASE_URL + AppConstants.transaction).replace(
        queryParameters: {'booking_id': id.toString()},
      ),
      headers: {
        'Authorization': 'Bearer $token',
        // 'Content-Type': 'application/json',
        // 'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      allTransaction = [];
      var result = jsonDecode(response.body);
      result['data'].forEach((transactionData) {
        allTransaction.add(Transaction.fromMap(transactionData));
      });
    }
    isLoading = false;
    update();
    return response.body;
  }
}
