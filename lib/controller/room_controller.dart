import 'dart:collection';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/data/rest_ds.dart';
import 'package:somudro_bilash_hotel/model/room_model.dart';
import 'package:intl/intl.dart';

class RoomController extends GetxController implements GetxService {
  int roomTypeId = 0;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  List<Room> availableRoom = [];

  SplayTreeMap<String, List<Room>> roomsByFloor = SplayTreeMap();

  Future getRooms() async {
    Response response = await RestDatasource.getRooms(
      roomTypeId,
      DateFormat('yyyy-MM-dd').format(fromDate),
      DateFormat('yyyy-MM-dd').format(toDate),
    );
    if (response.status.code == 200) {
      final data = response.body['data'];
      final List<Room> rooms = [];
      data.forEach((room) => rooms.add(Room.fromMap(room)));
      roomsByFloor.clear();
      rooms.forEach((room) {
        if (roomsByFloor['Floor ${room.floorId}'] == null) {
          roomsByFloor['Floor ${room.floorId}'] = [room];
        } else {
          roomsByFloor['Floor ${room.floorId}']!.add(room);
        }
      });
    }
    update();
  }
}
