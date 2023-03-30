import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/booking.dart';
import 'package:hotel_management/models/room.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class RoomProvider extends ChangeNotifier {
  final Ref ref;
  RoomProvider(this.ref);
  bool isLoading = false;
  List<Room> _rooms = [];
  List<Room> get rooms => _rooms;

  // late List<Booking> recentBookings;
  // late List<Booking> todayBookings;

  // add room
  Future<bool> addRoom(
      String roomNumber, String roomTypeId, BuildContext context) async {
    final response = await ref
        .read(apiClientProvider)
        .post('${AppConstants.addroomUrl}/rooms', data: {
      'number': roomNumber,
      'roomType': roomTypeId,
    });
    if (response.statusCode == 201) {
      final message = response.data['message'];
      showSnackBarMethod(context, message, true);
      return true;
    }
    final message = response.data['message'];
    showSnackBarMethod(context, message, false);
    return false;
  }

  // add room
  Future<bool> getRoomList(String? roomNumber) async {
    isLoading = true;
    notifyListeners();
    String url = AppConstants.totalRoom;
    if (roomNumber != null) {
      url = '${AppConstants.totalRoom}?roomNumber=$roomNumber';
    }

    final response = await ref.read(apiClientProvider).get(url);
    if (response.statusCode == 200) {
      _rooms = response.data['data'].map<Room>((room) {
        return Room.fromMap(room);
      }).toList();
      print(_rooms.length);
      isLoading = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  // room booking
  // Future<bool> bookRoom(
  //   String roomId,
  //   Booking bookingData,
  //   BuildContext context,
  // ) async {
  //   final response = await ref.read(apiClientProvider).post(
  //         '${AppConstants.roomBooking}/$roomId/bookings',
  //         data: jsonEncode(
  //           bookingData.toMap()..remove('room'),
  //         ),
  //       );

  //   final message = response.data['message'];
  //   if (response.statusCode == 201) {
  //     showSnackBarMethod(context, message, true);
  //     return true;
  //   }
  //   showSnackBarMethod(context, message, true);
  //   return false;
  // }

  // get recent booking rooms
  // Future<List<Booking>?> recentBookingRooms() async {
  //   final response =
  //       await ref.read(apiClientProvider).get(AppConstants.todayBookingRooms);
  //   if (response.statusCode == 200) {
  //     recentBookings = response.data['data'].map<Booking>((booking) {
  //       return Booking.fromMap(booking);
  //     }).toList();
  //     return recentBookings;
  //   }
  //   return null;
  // }

  // update room information
  Future<bool> updateRoomInfo(
    String roomNumber,
    String roomTypeId,
    String roomId,
    BuildContext context,
  ) async {
    final response = await ref
        .read(apiClientProvider)
        .put('${AppConstants.updateRoomInfo}/$roomId', data: {
      "number": roomNumber,
      "roomType": roomTypeId,
    });
    final message = response.data['message'];
    if (response.statusCode == 200) {
      showSnackBarMethod(context, message, true);
      return true;
    }
    showSnackBarMethod(context, message, false);
    return false;
  }

  // delete room
  Future<bool> deleteRoom(String roomId, BuildContext context) async {
    final response = await ref
        .read(apiClientProvider)
        .delete('${AppConstants.deleteRoom}/$roomId');
    final message = response.data['message'];
    if (response.statusCode == 200) {
      showSnackBarMethod(context, message, true);
      return true;
    }
    showSnackBarMethod(context, message, false);
    return false;
  }

  todayBookingRooms() {}
}

final roomProvider = ChangeNotifierProvider((ref) => RoomProvider(ref));
