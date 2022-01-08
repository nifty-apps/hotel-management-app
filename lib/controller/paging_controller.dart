import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PagingController extends GetxController implements GetxService {
  String currentPage = 'dashboard';
  
  //String get currentPage => _currentPage;

  void changePage(String page) {
    currentPage = page;
    update();
  }
}
