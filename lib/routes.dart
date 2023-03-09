import 'package:flutter/material.dart';
import 'package:hotel_management/view/screens/auth/add_hotel.dart';
import 'package:hotel_management/view/screens/auth/login.dart';
import 'package:hotel_management/view/screens/auth/signup.dart';
import 'package:hotel_management/view/screens/dashboard/dashboard1.dart';
import 'package:hotel_management/view/screens/intro/intro.dart';
import 'package:hotel_management/view/screens/profile/profile.dart';
import 'package:hotel_management/view/screens/room/add_room.dart';
import 'package:hotel_management/view/screens/room/available.dart';
import 'package:hotel_management/view/screens/room/room_booking.dart';
import 'package:hotel_management/view/screens/room/today_bookings.dart';
import 'package:hotel_management/view/screens/room/total.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String addHotel = '/addHotel';
  static const String intro = '/intro';
  static const String dashboard = '/dashboard';
  static const String addRoom = '/addRoom';
  static const String totalRooms = '/totalRooms';
  static const String availableRoom = '/availableRoom';
  static const String todayBookingsRoom = '/todayBookingsRoom';
  static const String bookingRoom = '/bookingRoom';
  static const String profile = '/profile';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intro:
        return MaterialPageRoute(
          builder: (context) => IntroScreen(),
        );
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
          builder: (context) => MyHomePage(),
        );
      case addRoom:
        List<dynamic>? args = settings.arguments as List?;
        return MaterialPageRoute(
          builder: (context) => AddRoomScreen(
            isUpdate: args?[0] ?? false,
            roomData: args?[1],
          ),
        );
      case totalRooms:
        return MaterialPageRoute(
          builder: (context) => TotalRoomSrceen(),
        );
      case availableRoom:
        return MaterialPageRoute(
          builder: (context) => AvailableRoomScreen(),
        );
      case todayBookingsRoom:
        return MaterialPageRoute(
          builder: (context) => TodayBookingsScreen(),
        );
      case bookingRoom:
        return MaterialPageRoute(
          builder: (context) => RoomBooking(
            roomId: settings.arguments.toString(),
          ),
        );
      case profile:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
    }
    return null;
  }
}
