import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/paging_controller.dart';

Future<String> init() async {
  // Controller
  Get.lazyPut(() => PagingController());

  // Retrieving localized data
  return 'hira';
}
