import 'package:get/get.dart';
import 'package:hotel_management/utils/api_client.dart';

Future<void> init() async {
  // Get.lazyPut(() => RoomController(), fenix: true);
  // Get.lazyPut(() => AuthController(), fenix: true);
  // Get.lazyPut(() => BookingController(), fenix: true);
  // Get.lazyPut(() => RoomTypeController(), fenix: true);
  // Get.lazyPut(() => ReportController(), fenix: true);
  // Get.lazyPut(() => PaymentUpdateController(), fenix: true);
  Get.lazyPut(() => ApiClient());
}
