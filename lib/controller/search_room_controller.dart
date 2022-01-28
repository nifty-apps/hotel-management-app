import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/data/rest_ds.dart';
import 'package:somudro_bilash_hotel/model/rooms_model.dart';
import 'package:intl/intl.dart';

class SearchRoomController extends GetxController implements GetxService {
  int roomTypeId = 0;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  List<Room> allRooms = [];
  List<Room> availableRoom = [];

  Map<String, List<Room>> roomsByFloor = {};

  // Future getAllRooms() async {
  //   Response response = await RestDatasource.getAllRooms();
  //   print('All rooms response body: ${response.body}');
  //   if (response.status.code == 200) {
  //     allRooms = [];
  //     allRooms.addAll(Rooms.fromJson(response.body).data);
  //   }
  //   update();
  // }

  Future getRooms() async {
    Response response = await RestDatasource.getRooms(
      roomTypeId,
      DateFormat('yyyy-MM-dd').format(fromDate),
      DateFormat('yyyy-MM-dd').format(toDate),
    );
    if (response.status.code == 200) {
      print('Rooms: ${response.body}');
      response.body['data'].forEach((element) {
        final List<Room> rooms = [];
        element['rooms'].forEach((room) => rooms.add(Room.fromMap(room)));
        roomsByFloor[element['name']] = rooms;
      });
      print('roomsByFloor: $roomsByFloor');
    }
    update();
  }

  Future availableRooms(DateTime startDate, DateTime endDate) async {
    Response response = await RestDatasource.searchRooms(
      DateFormat('yyyy-MM-dd').format(startDate),
      DateFormat('yyyy-MM-dd').format(endDate),
    );
    print('Available rooms response body: ${response.body}');
    if (response.status.code == 200) {
      availableRoom = [];
      // availableRoom.addAll(Rooms.fromJson(response.body).data);
    }
    update();
  }
}
