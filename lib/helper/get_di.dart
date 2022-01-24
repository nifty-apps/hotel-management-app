import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/auth_controller.dart';
import 'package:somudro_bilash_hotel/controller/booking_controller.dart';
import 'package:somudro_bilash_hotel/controller/reports_controller.dart';
import 'package:somudro_bilash_hotel/controller/room_type_controller.dart';
import 'package:somudro_bilash_hotel/controller/search_room_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => SearchRoomController());
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => BookingController());
  Get.lazyPut(() => RoomTypeController());
  Get.lazyPut(() => ReportController());
}
