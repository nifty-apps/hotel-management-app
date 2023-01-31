import 'package:get/get.dart';
import 'package:hotel_management/controller/auth_controller.dart';
import 'package:hotel_management/controller/booking_controller.dart';
import 'package:hotel_management/controller/payment_update_controller.dart';
import 'package:hotel_management/controller/reports_controller.dart';
import 'package:hotel_management/controller/room_type_controller.dart';
import 'package:hotel_management/controller/room_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => RoomController(), fenix: true);
  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => BookingController(), fenix: true);
  Get.lazyPut(() => RoomTypeController(), fenix: true);
  Get.lazyPut(() => ReportController(), fenix: true);
  Get.lazyPut(() => PaymentUpdateController(), fenix: true);
}
