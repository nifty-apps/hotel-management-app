// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samudra_bilash_hotel/controller/paging_controller.dart';
import 'package:samudra_bilash_hotel/controller/search_room_controller.dart';
import 'package:samudra_bilash_hotel/view/screens/home/home_screen.dart';
import 'package:samudra_bilash_hotel/view/screens/login_screen/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Get.lazyPut(() => PagingController());
  Get.lazyPut(() => SearchroomController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            final pref = snapshot.data;
            print(
              pref!.getString("Token"),
            );
            if (pref.getString("Token") == null) {
              return LoginPage();
            } else {
              return HomeScreen();
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
