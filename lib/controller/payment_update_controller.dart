// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hotel_management/util/app_constants.dart';

// var client = http.Client();

// class PaymentUpdateController extends GetxController {
//   bool isLoading = false;
//   Future<String> paymentUpdate(String id, String amount) async {
//     isLoading = true;
//     update();
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     var token = preferences.getString("Token");
//     http.Response response = await client.post(
//         Uri.parse(AppConstants.BASE_URL + AppConstants.paymentUpdate),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//         body: {
//           'booking_id': id,
//           'paid_amount': amount
//         });
//     if (response.statusCode == 200) {
//       Get.snackbar('Update', 'Payment updated successfuly',
//           snackPosition: SnackPosition.BOTTOM);
//     } else {
//       Get.snackbar(
//           'Validation error', 'Paid amount cannot bigger than total fare',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//     isLoading = false;
//     update();
//     return response.body;
//   }
// }
