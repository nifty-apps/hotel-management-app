import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/room.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class RoomTypeProvider extends ChangeNotifier {
  final Ref ref;
  RoomTypeProvider({required this.ref});
  bool isLoading = false;

  List<RoomType> _roomType = [];
  List<RoomType> get roomType => _roomType;

  Future<bool> addRoomType(
      String room, int rent, String description, BuildContext context) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstants.roomType, data: {
      'room': room,
      'rent': rent,
      'description': description,
    });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<RoomType>?> getRoomTypeList() async {
    try {
      final response =
          await ref.read(apiClientProvider).get(AppConstants.roomType);
      print(response.data);
      if (response.statusCode == 200) {
        isLoading = false;
        _roomType = response.data['data'].map<RoomType>((roomType) {
          return RoomType.fromMap(roomType);
        }).toList();
        return _roomType;
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  Future<bool> updateRoomType(String id, BuildContext context, String roomType,
      int rent, String description) async {
    final response = await ref
        .read(apiClientProvider)
        .put(AppConstants.roomType + '/$id', data: {
      'roomType': roomType,
      'rent': rent,
      'description': description,
    });
    if (response.statusCode == 200) {
      final message = response.data['message'];
      showSnackBarMethod(context, message, true);
      return true;
    }
    final message = response.data['message'];
    showSnackBarMethod(context, message, false);
    return false;
  }

  Future<bool> deleteRoomType(String id, BuildContext context) async {
    final response = await ref
        .read(apiClientProvider)
        .delete(AppConstants.roomType + '/$id');
    if (response.statusCode == 200) {
      final message = response.data['message'];
      showSnackBarMethod(context, message, true);
      return true;
    }
    final message = response.data['message'];
    showSnackBarMethod(context, message, false);
    return false;
  }
}

final roomTypeProvider =
    ChangeNotifierProvider((ref) => RoomTypeProvider(ref: ref));
