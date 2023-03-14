import 'package:flutter/material.dart';
import 'package:hotel_management/view/screens/auth/add_hotel.dart';
import 'package:hotel_management/view/screens/auth/login.dart';
import 'package:hotel_management/view/screens/auth/signup.dart';
import 'package:hotel_management/view/screens/checkin/checkin.dart';
import 'package:hotel_management/view/screens/checkin/choice_room.dart';
import 'package:hotel_management/view/screens/checkin/confirm_checking.dart';
import 'package:hotel_management/view/screens/checkin/edit_checking_info.dart';
import 'package:hotel_management/view/screens/checkin/payment.dart';
import 'package:hotel_management/view/screens/checkin/update_customer_room.dart';
import 'package:hotel_management/view/screens/checkout/checkout.dart';
import 'package:hotel_management/view/screens/checkout/checkout_due.dart';
import 'package:hotel_management/view/screens/dashboard/dashboard.dart';
import 'package:hotel_management/view/screens/intro/intro.dart';
import 'package:hotel_management/view/screens/profile/profile.dart';
import 'package:hotel_management/view/screens/room/add_room.dart';
import 'package:hotel_management/view/screens/room/available.dart';
import 'package:hotel_management/view/screens/room/room_booking.dart';
import 'package:hotel_management/view/screens/room/today_bookings.dart';
import 'package:hotel_management/view/screens/room/total.dart';

class Routes {
  static const String splash = '/';
  static const String intro = '/intro';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String addHotel = '/addHotel';
  static const String dashboard = '/dashboard';
  static const String checkin = '/checkin';
  static const String choiceRooms = '/choiceRooms';
  static const String payment = '/payment';
  static const String confirmCheckin = '/confirmCheckin';
  static const String editCheckinInfo = '/editCheckinInfo';
  static const String updateCustomerRoom = '/updateCustomerRoom';
  static const String checkout = '/checkout';
  static const String checkoutDue = '/checkoutDue';

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
          builder: (context) => DashboardScreen(),
        );
      case checkin:
        return MaterialPageRoute(
          builder: (context) => CheckinScreen(),
        );
      case choiceRooms:
        return MaterialPageRoute(
          builder: (context) => ChoiceRoomScreen(),
        );
      case payment:
        return MaterialPageRoute(
          builder: (context) => PaymentScreen(),
        );
      case confirmCheckin:
        return MaterialPageRoute(
          builder: (context) =>
              ConfirmCheckingScreen(isCheckin: settings.arguments as bool),
        );
      case editCheckinInfo:
        return MaterialPageRoute(
          builder: (context) => EditCheckingInfoScreen(),
        );
      case updateCustomerRoom:
        return MaterialPageRoute(
          builder: (context) => UpdateCustomerRoom(),
        );
      case checkout:
        return MaterialPageRoute(
          builder: (context) => CheckoutScreen(),
        );
      case checkoutDue:
        return MaterialPageRoute(
          builder: (context) => CheckoutDueScreen(),
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
