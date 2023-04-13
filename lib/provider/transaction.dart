import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/transaction.dart';
import 'package:hotel_management/models/transaction_history.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class TransactionProvider extends ChangeNotifier {
  final Ref ref;
  TransactionProvider({required this.ref});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Transaction> _transaction = [];
  List<Transaction> get transaction => _transaction;

  HotelRevenue? _hotelRevenue;
  HotelRevenue? get hotelRevenue => _hotelRevenue;

  Future<bool> addTransaction(
    BuildContext context, {
    required String paymentMethod,
    required String bookingId,
    required int amount,
  }) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.transaction + '/$bookingId', data: {
      'paymentMethod': paymentMethod,
      'amount': amount,
    });
    if (response.statusCode == 201) {
      final message = response.data['message'];
      showSnackBarMethod(context, message, true);
      return true;
    }
    final message = response.data['message'];
    showSnackBarMethod(context, message, false);
    return false;
  }

  Future<List<Transaction>?> getTransactionList(
      String? bookingId, bool singleBooking) async {
    try {
      final response = await ref.read(apiClientProvider).get(singleBooking
          ? AppConstants.transaction + '/?bookingId=$bookingId'
          : AppConstants.transaction);
      if (response.statusCode == 200) {
        print(response.data);
        _transaction = response.data['data'].map<Transaction>((transaction) {
          return Transaction.fromMap(transaction);
        }).toList();
        print(_transaction);
        return _transaction;
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  Future<List<Transaction>?> getTransactionHistory(
      {required DateTime fromDate, required DateTime toDate}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await ref.read(apiClientProvider).get(
            AppConstants.transaction + "/?fromDate=$fromDate&toDate=$toDate",
          );
      if (response.statusCode == 200) {
        _transaction = response.data['data'].map<Transaction>((transaction) {
          return Transaction.fromMap(transaction);
        }).toList();
        print(_transaction);
        _isLoading = false;
        notifyListeners();
        return _transaction;
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  Future<bool> getRevenue({required String timeRange}) async {
    print(timeRange);

    _isLoading = true;
    notifyListeners();
    final response = await ref.read(apiClientProvider).get(
          AppConstants.getRevenue + "?timeRange=$timeRange",
        );
    if (response.statusCode == 200) {
      _hotelRevenue = HotelRevenue.fromMap(response.data['data']);
      print(_hotelRevenue);
      _isLoading = false;
      notifyListeners();
      return true;
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }
}

final transactionProvider = ChangeNotifierProvider<TransactionProvider>(
    (ref) => TransactionProvider(ref: ref));
