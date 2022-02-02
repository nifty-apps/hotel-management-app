import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somudro_bilash_hotel/data/rest_ds.dart';
import 'package:somudro_bilash_hotel/model/booking_model.dart';
import 'package:somudro_bilash_hotel/model/response/transaction_response.dart';
import 'package:somudro_bilash_hotel/util/app_constants.dart';
import 'package:http/http.dart' as http;

final client = http.Client();

class BookingController extends GetxController implements GetxService {
  late String name;
  late String phone;
  String address = 'Pearabag Moghbazar';
  int roomId = 12;
  late DateTime checkInDate;
  late DateTime checkOutDate;
  String checkInTime = '10:00';
  String checkOutTime = '04:00';
  String bookingStatus = 'booked';
  int paidAmount = 2000;
  int roomFare = 4000;

  Future<bool> bookRoom() async {
    Response response = await RestDatasource.bookRoom(
      Booking(
        roomId: roomId,
        name: name,
        phone: phone,
        address: address,
        bookingStatus: bookingStatus,
        roomFare: roomFare,
        paidAmount: paidAmount,
        checkInDate: DateFormat('yyyy-MM-dd').format(checkInDate),
        checkOutDate: DateFormat('yyyy-MM-dd').format(checkOutDate),
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Booking>> getBookingDetails(int roomId) async {
    print(roomId);
    Response response = await RestDatasource.getBookingDetails(roomId);
    List<Booking> bookings = (response.body['data'] as List)
        .map((el) => Booking.fromMap(el))
        .toList();
    return bookings;
  }

  Future<bool> updateBooking(Booking booking) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("Token");
    http.Response response = await client.put(
      Uri.parse(
        AppConstants.BASE_URL + AppConstants.bookingUpdate + '/${booking.id}',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: booking.toJson(),
    );
    print("update data: ${response.body}");
    return response.statusCode == 200;
  }

  Future<List<Transaction>> getTransactions(int bookingId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("Token");
    http.Response response = await client.get(
      Uri.parse(AppConstants.BASE_URL + AppConstants.transaction).replace(
        queryParameters: {'booking_id': bookingId.toString()},
      ),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return (result['data'] as List)
          .map((e) => Transaction.fromMap(e))
          .toList();
    } else {
      return [];
    }
  }
}
