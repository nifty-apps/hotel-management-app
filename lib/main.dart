import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_management/helper/get_di.dart' as di;
import 'package:hotel_management/theme/theme.dart';
import 'package:hotel_management/view/screens/dashboard/dashboard_screen.dart';
import 'package:hotel_management/view/screens/login_screen/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            final pref = snapshot.data;
            if (pref!.getString('Token') == null) {
              return LoginPage();
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
