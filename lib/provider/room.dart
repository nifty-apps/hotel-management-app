import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/room.dart';
import 'package:hotel_management/models/room_report.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class RoomProvider extends ChangeNotifier {
  final Ref ref;
  RoomProvider(this.ref);
  bool isLoading = false;
  List<Room> _rooms = [];
  List<Room> get rooms => _rooms;

  List<RoomReport> _reports = [];
  List<RoomReport> get reports => _reports;

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

  // get rooms report
  Future<bool> getRoomsReport() async {
    isLoading = true;
    notifyListeners();
    final response =
        await ref.read(apiClientProvider).get(AppConstants.getRoomsReport);
    if (response.statusCode == 200) {
      _reports = response.data['data'].map<RoomReport>((report) {
        return RoomReport.fromMap(report);
      }).toList();
      print(_reports);
      isLoading = false;
      notifyListeners();
      return true;
    }
    return false;
  }
}

final roomProvider = ChangeNotifierProvider((ref) => RoomProvider(ref));
