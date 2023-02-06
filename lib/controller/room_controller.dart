import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/add_room.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class RoomProvider {
  final Ref ref;
  RoomProvider(this.ref);

  // add room
  Future<bool> addRoom(
      AddRoom room, String hotelId, BuildContext context) async {
    final response = await ref
        .read(apiClientProvider)
        .post('${AppConstants.addroomUrl}/hotels/$hotelId/rooms', data: room);
    if (response.statusCode == 201) {
      final message = response.data['message'];
      showSnackBarMethod(context, message,true);
      return true;
    }
    final message = response.data['message'];
    showSnackBarMethod(context, message,false);
    return false;
  }
}

final roomProvider = Provider((ref) => RoomProvider(ref));
