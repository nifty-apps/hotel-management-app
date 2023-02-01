import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_management/helper/get_di.dart' as di;
import 'package:hotel_management/services/local_strorage.dart';
import 'package:hotel_management/theme/theme.dart';
import 'package:hotel_management/view/screens/auth/add_hotel.dart';
import 'package:hotel_management/view/screens/auth/login.dart';
import 'package:hotel_management/view/screens/dashboard/dashboard.dart';

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyAppTheme.lightTheme,
      home: FutureBuilder(
        future: Get.find<LocalStorage>().loadTokenAndUser(),
        builder: (context, AsyncSnapshot<List<dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Login();
            }
            if (snapshot.data!.last.hotel == null) {
              return AddHotel();
            } else {
              return DashboardScreen();
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
