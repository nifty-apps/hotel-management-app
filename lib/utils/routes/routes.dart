import 'package:flutter/material.dart';
import 'package:samudra_bilash_hotel/auth.dart';
import 'package:samudra_bilash_hotel/main.dart';
import 'package:samudra_bilash_hotel/view/screens/dashboard/dashboard.dart';
import 'package:samudra_bilash_hotel/view/screens/home/home_screen.dart';
import 'package:samudra_bilash_hotel/view/screens/login_screen/login.dart';
@override
  onAuthStateChanged(AuthState state) {
    // BuildContext _ctx= new BuildContext();
    if (state == AuthState.LOGGED_IN)
      print('logggedint-------------------------------------');
   // Navigator.of(_ctx).pushReplacementNamed("/home");
  }
final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/home':         (BuildContext context) => new HomeScreen(),
  '/' :          (BuildContext context) => new LoginScreen(),
};