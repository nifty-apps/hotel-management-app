import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/auth_controller.dart';
import 'package:somudro_bilash_hotel/controller/booking_controller.dart';
import 'package:somudro_bilash_hotel/controller/payment_update_controller.dart';
import 'package:somudro_bilash_hotel/controller/reports_controller.dart';
import 'package:somudro_bilash_hotel/controller/room_type_controller.dart';
import 'package:somudro_bilash_hotel/controller/room_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => RoomController(), fenix: true);
  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => BookingController(), fenix: true);
  Get.lazyPut(() => RoomTypeController(), fenix: true);
  Get.lazyPut(() => ReportController(), fenix: true);
  Get.lazyPut(() => PaymentUpdateController(), fenix: true);
}
