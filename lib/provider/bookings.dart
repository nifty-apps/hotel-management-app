import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/available_room.dart';
import 'package:hotel_management/models/booking.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class BookingProvider extends ChangeNotifier {
  final Ref ref;
  BookingProvider(this.ref);

  List<AvailableRoom> _availableRooms = [];
  List<AvailableRoom> get availableRooms => _availableRooms;

  List<Bookings> _bookingList = [];
  List<Bookings> get bookingList => _bookingList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // Booking
  Future<bool> roomBooking(
      String name,
      String phone,
      List<String> rooms,
      String checkIn,
      String checkOut,
      int total,
      int discount,
      String status,
      BuildContext context) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstants.roomBooking, data: {
      "customer": {
        "name": name,
        "phone": phone,
      },
      "rooms": rooms,
      "checkIn": checkIn,
      "checkOut": checkOut,
      "total": total,
      "discount": discount,
      "status": status
    });
    if (response.statusCode == 201) {
      return true;
    }
    final message = response.data['message'];
    showSnackBarMethod(context, message, false);
    return false;
  }

  // Get Available Rooms
  Future<bool> getAvailableRooms(String fromDate, String toDate) async {
    final response = await ref.read(apiClientProvider).get(
        '${AppConstants.availableRooms}?fromDate=$fromDate&toDate=$toDate');
    if (response.statusCode == 200) {
      _availableRooms = response.data['data']
          .map<AvailableRoom>((room) => AvailableRoom.fromMap(room))
          .toList();
      return true;
    }
    return false;
  }

  // Get Recent Bookings List
  Future<List<Bookings>?> getRecentBookings() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstants.recenRoombookins);
    if (response.statusCode == 200) {
      _bookingList = response.data['data']
          .map<Bookings>((booking) => Bookings.fromMap(booking))
          .toList();
      return _bookingList;
    }
    return null;
  }

  // Get Bookings List
  Future<List<Bookings>> getBookingsList(
    DateTime checkinDate,
    DateTime checkoutDate,
    String status,
  ) async {
    _isLoading = true;
    notifyListeners();
    final response = await ref.read(apiClientProvider).get(
        "${AppConstants.getRoomBookings}?checkInDate=$checkinDate&checkOutDate=$checkoutDate&status=$status");
    if (response.statusCode == 200) {
      _bookingList = response.data['data']
          .map<Bookings>((booking) => Bookings.fromMap(booking))
          .toList();
      _isLoading = false;
      notifyListeners();
      return _bookingList;
    }
    _isLoading = false;
    notifyListeners();
    return [];
  }
}

final bookingProvider =
    ChangeNotifierProvider<BookingProvider>((ref) => BookingProvider(ref));
