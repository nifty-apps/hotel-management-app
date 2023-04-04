import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/transaction.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class TransactionProvider extends ChangeNotifier {
  final Ref ref;
  TransactionProvider({required this.ref});
  bool isLoading = false;

  List<Transaction> _transaction = [];
  List<Transaction> get transaction => _transaction;

  Future<bool> addTransaction(String paymentMethod, String bookingId,
      int amount, BuildContext context) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.transaction + '/$bookingId', data: {
      'paymentMethod': paymentMethod,
      'amount': amount,
    });
    if (response.statusCode == 200) {
      final message = response.data['message'];
      showSnackBarMethod(context, message, false);
      return true;
    }
    final message = response.data['message'];
    showSnackBarMethod(context, message, false);
    return false;
  }

  Future<List<Transaction>?> getTransactionList(
      String? bookingId, bool singleBooking) async {
    print(bookingId);
    print(singleBooking);
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

  // Future<bool> updateTransaction(String id, BuildContext context, String paymentMethod, int amount) async{
  //   final response = await ref.read(apiClientProvider).put(AppConstants.transaction + '/$id', data: {
  //     'paymentMethod': paymentMethod,
  //     'amount': amount,
  //   });
  //   if(response.statusCode == 200){
  //     final message = response.data['message'];
  //     showSnackBarMethod(context, message, true);
  //     return true;
  //   }
  //   return false;
  // }

  // Future<bool> deleteTransaction(String id, BuildContext context) async{
  //   final response = await ref.read(apiClientProvider).delete(AppConstants.transaction + '/$id');
  //   if(response.statusCode == 200){
  //     final message = response.data['message'];
  //     showSnackBarMethod(context, message, true);
  //     return true;
  //   }
  //   return false;
  // }
}

final transactionProvider = ChangeNotifierProvider<TransactionProvider>(
    (ref) => TransactionProvider(ref: ref));
