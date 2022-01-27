import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:somudro_bilash_hotel/data/rest_ds.dart';

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
}
