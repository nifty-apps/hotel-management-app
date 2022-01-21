import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/data/rest_ds.dart';

class BookingController extends GetxController implements GetxService {
  String name = 'Mohammad Ali';
  int phone = 01826078348;
  String address = 'Pearabag Moghbazar';
  int roomId = 12;
  String checkInDate = '2021-12-16';
  String checkOutDate = '2021-12-24';
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
      checkInDate,
      checkOutDate,
      bookingStatus,
      roomFare,
      paidAmount,
    );
    print(response.body);
    return true;
  }
}
