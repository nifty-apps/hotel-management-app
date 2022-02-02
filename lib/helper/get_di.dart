import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/auth_controller.dart';
import 'package:somudro_bilash_hotel/controller/booking_controller.dart';
import 'package:somudro_bilash_hotel/controller/payment_update_controller.dart';
import 'package:somudro_bilash_hotel/controller/reports_controller.dart';
import 'package:somudro_bilash_hotel/controller/room_type_controller.dart';
import 'package:somudro_bilash_hotel/controller/room_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => RoomController());
  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => BookingController());
  Get.lazyPut(() => RoomTypeController());
  Get.lazyPut(() => ReportController());
  Get.lazyPut(() => PaymentUpdateController());
}
