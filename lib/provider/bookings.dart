import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/available_room.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class BookingProvider extends ChangeNotifier {
  final Ref ref;
  BookingProvider(this.ref);

  List<AvailableRoom> _availableRooms = [];
  List<AvailableRoom> get availableRooms => _availableRooms;

  bool _isLoading = true;
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
      "total":total,
      "discount":discount,
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
      print(_availableRooms.length);
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }
}

final bookingProvider =
    ChangeNotifierProvider<BookingProvider>((ref) => BookingProvider(ref));
