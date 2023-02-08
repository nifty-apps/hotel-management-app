import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/add_room.dart';
import 'package:hotel_management/models/room.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class RoomProvider {
  final Ref ref;
  RoomProvider(this.ref);

  late List<Room> rooms;

  // add room
  Future<bool> addRoom(
      AddRoom room, String hotelId, BuildContext context) async {
    final response = await ref
        .read(apiClientProvider)
        .post('${AppConstants.addroomUrl}/rooms', data: room);
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
  Future<List<Room>?> getRoomList() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstants.totalRoom);
    if (response.statusCode == 200) {
      rooms = response.data['data'].map<Room>((room) {
        return Room.fromMap(room);
      }).toList();
      return rooms;
    }
    return null;
  }
}

final roomProvider = Provider((ref) => RoomProvider(ref));
