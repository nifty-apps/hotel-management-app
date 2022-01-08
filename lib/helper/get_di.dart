import 'dart:convert';

import 'package:get/get.dart';
import 'package:samudra_bilash_hotel/controller/paging_controller.dart';
import 'dart:convert';

Future<String> init() async {
  // Controller
  Get.lazyPut(() => PagingController());

  // Retrieving localized data
  return 'hira';
}
