import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/data/rest_ds.dart';
import 'package:somudro_bilash_hotel/model/rooms_model.dart';
import 'package:intl/intl.dart';

class SearchRoomController extends GetxController implements GetxService {
  DateTime fromSelectedDate = DateTime.now();
  DateTime toSelectedDate = DateTime.now();
  List<Data> allRooms = [];
  List<Data> availableRoom = [];

  Map<String, List> rooms = {
    'Floor 1': [
      // Rooms
    ],
    'Floor 2': [
      // Rooms
    ],
  };

  List<Data> firstFloor = [];
  List<Data> secondFloor = [];
  List<Data> thirdFloor = [];
  List<Data> forthFloor = [];

  Future getAllRooms() async {
    Response response = await RestDatasource.getAllRooms();
    print('All rooms response body: ${response.body}');
    if (response.status.code == 200) {
      allRooms = [];
      firstFloor = [];
      secondFloor = [];
      thirdFloor = [];
      forthFloor = [];
      allRooms.addAll(Rooms.fromJson(response.body).data);
    }
    for (int i = 0; i < allRooms.length; ++i) {
      if (allRooms[i].floorId == 1) {
        firstFloor.add(allRooms[i]);
      } else if (allRooms[i].floorId == 2) {
        secondFloor.add(allRooms[i]);
      } else if (allRooms[i].floorId == 3) {
        thirdFloor.add(allRooms[i]);
      } else {
        forthFloor.add(allRooms[i]);
      }
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
      availableRoom.addAll(Rooms.fromJson(response.body).data);
    }
    update();
  }
}
