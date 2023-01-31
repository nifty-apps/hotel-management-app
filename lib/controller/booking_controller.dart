// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hotel_management/data/rest_ds.dart';
// import 'package:hotel_management/model/booking_model.dart';
// import 'package:hotel_management/model/response/transaction_response.dart';
// import 'package:hotel_management/util/app_constants.dart';
// import 'package:http/http.dart' as http;

// final client = http.Client();

// class BookingController extends GetxController implements GetxService {
//   late String name;
//   late String phone;
//   String? address;
//   late int roomId;
//   late DateTime checkInDate;
//   late DateTime checkOutDate;
//   String bookingStatus = 'booked';
//   late int paidAmount;
//   late int roomFare;

//   Future<bool> bookRoom() async {
//     Response response = await RestDatasource.bookRoom(
//       Booking(
//         roomId: roomId,
//         name: name,
//         phone: phone,
//         address: address,
//         bookingStatus: bookingStatus,
//         roomFare: roomFare,
//         paidAmount: paidAmount,
//         checkInDate: checkInDate,
//         checkOutDate: checkOutDate,
//       ),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<List<Booking>> getBookingDetails(int roomId) async {
//     Response response = await RestDatasource.getBookingDetails(roomId);
//     List<Booking> bookings = (response.body['data'] as List)
//         .map((el) => Booking.fromMap(el))
//         .toList();
//     return bookings;
//   }

//   Future<bool> updateBooking(Booking booking) async {
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     var token = preferences.getString("Token");
//     http.Response response = await client.put(
//       Uri.parse(
//         AppConstants.BASE_URL + AppConstants.bookingUpdate + '/${booking.id}',
//       ),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//       body: booking.toJson(),
//     );
//     return response.statusCode == 200;
//   }

//   Future<List<Transaction>> getTransactions(int bookingId) async {
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     var token = preferences.getString("Token");
//     http.Response response = await client.get(
//       Uri.parse(AppConstants.BASE_URL + AppConstants.transaction).replace(
//         queryParameters: {'booking_id': bookingId.toString()},
//       ),
//       headers: {'Authorization': 'Bearer $token'},
//     );
//     if (response.statusCode == 200) {
//       var result = jsonDecode(response.body);
//       return (result['data'] as List)
//           .map((e) => Transaction.fromMap(e))
//           .toList();
//     } else {
//       return [];
//     }
//   }
// }
