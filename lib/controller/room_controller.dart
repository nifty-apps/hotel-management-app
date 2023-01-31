// import 'dart:collection';
// import 'package:get/get.dart';
// import 'package:hotel_management/data/rest_ds.dart';
// import 'package:hotel_management/model/room_model.dart';

// class RoomController extends GetxController implements GetxService {
//   int roomTypeId = 0;
//   DateTime fromDate = DateTime.now();
//   DateTime toDate = DateTime.now();
//   List<Room> availableRoom = [];

//   SplayTreeMap<String, List<Room>> roomsByFloor = SplayTreeMap();

//   Future getRooms() async {
//     Response response = await RestDatasource.getRooms(
//       roomTypeId,
//       fromDate.toIso8601String(),
//       toDate.toIso8601String(),
//     );
//     if (response.status.code == 200) {
//       final data = response.body['data'];
//       final List<Room> rooms = [];
//       data.forEach((room) => rooms.add(Room.fromMap(room)));
//       roomsByFloor.clear();
//       rooms.forEach((room) {
//         if (roomsByFloor['Floor ${room.floorId}'] == null) {
//           roomsByFloor['Floor ${room.floorId}'] = [room];
//         } else {
//           roomsByFloor['Floor ${room.floorId}']!.add(room);
//         }
//       });
//     }
//     update();
//   }
// }
