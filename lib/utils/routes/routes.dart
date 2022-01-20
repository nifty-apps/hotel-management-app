import 'package:flutter/material.dart';
import 'package:somudro_bilash_hotel/view/screens/home/home_screen.dart';
import 'package:somudro_bilash_hotel/view/screens/login_screen/login_page.dart';

@override
// onAuthStateChanged(AuthState state) {
//   // BuildContext _ctx= new BuildContext();
//   if (state == AuthState.LOGGED_IN)
//     print('logggedint-------------------------------------');
//   // Navigator.of(_ctx).pushReplacementNamed("/home");
// }

final routes = {
  '/login': (BuildContext context) => new HomeScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/': (BuildContext context) => new LoginPage(),
};
