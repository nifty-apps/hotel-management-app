import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somudro_bilash_hotel/data/rest_ds.dart';
import 'package:somudro_bilash_hotel/model/booking_model.dart';
import 'package:somudro_bilash_hotel/util/app_constants.dart';
import 'package:http/http.dart' as http;

final client = http.Client();

class BookingController extends GetxController implements GetxService {
  late String name;
  int phone = 01826078348;
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
      name,
      phone,
      address,
      roomId,
      DateFormat('yyyy-MM-dd').format(checkInDate),
      DateFormat('yyyy-MM-dd').format(checkOutDate),
      bookingStatus,
      roomFare,
      paidAmount,
    );
    print(response.body);
    return true;
  }

  Future<List<Booking>> getBookingDetails(int roomId) async {
    Response response = await RestDatasource.getBookingDetails(roomId);
    List<Booking> bookings = (response.body['data'] as List)
        .map((el) => Booking.fromMap(el))
        .toList();
    return bookings;
  }

  Future<String> updateBooking() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("Token");
    http.Response response = await client.put(
      Uri.parse(AppConstants.BASE_URL + AppConstants.bookingUpdte),
      headers: {
        'Authorization': 'Bearer $token',
        // 'Content-Type': 'application/json',
        // 'Accept': 'application/json',
      },
      body: {},
    );
    if (response.statusCode == 200) {
      Get.snackbar('Success', " Successfully Updated!");
    } else {
      Get.snackbar('Error', 'Update unsuccessful');
    }
    return response.body;
  }
}
