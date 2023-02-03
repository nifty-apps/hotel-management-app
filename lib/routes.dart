import 'package:flutter/material.dart';
import 'package:hotel_management/view/screens/auth/add_hotel.dart';
import 'package:hotel_management/view/screens/auth/login.dart';
import 'package:hotel_management/view/screens/auth/registration.dart';
import 'package:hotel_management/view/screens/dashboard/dashboard.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String addHotel = '/addHotel';
  static const String dashboard = '/dashboard';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case signUp:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        );
      case addHotel:
        return MaterialPageRoute(
          builder: (context) => AddHotelScreen(),
        );
      case dashboard:
        return MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        );
    }
    return null;
  }
}
