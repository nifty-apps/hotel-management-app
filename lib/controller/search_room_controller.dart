// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/data/rest_ds.dart';

import 'package:somudro_bilash_hotel/model/rooms_model.dart';
import 'package:intl/intl.dart';

class SearchroomController extends GetxController implements GetxService {
  String fromSelectedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  String toSelectedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  List<Data> allRooms = [];
  List<Data> firstFloor = [];
  List<Data> secondFloor = [];
  List<Data> thirdFloor = [];
  List<Data> forthFloor = [];

  void changeFromSelectedDate(String date) {
    fromSelectedDate = date;
    print(fromSelectedDate);
    update();
  }

  void changeToSelectedDate(String from, String to) {
    toSelectedDate = to;
    fromSelectedDate = from;
    print(toSelectedDate);
    update();
  }

  Future getAllRooms() async {
    print('enter the method of contorller----------');
    Response response = await RestDatasource.getAllRooms();
    print(response.status.code);
    print(response.body);
    // ignore: unrelated_type_equality_checks
    if (response.status.code == 200) {
      allRooms = [];
      firstFloor = [];
      secondFloor = [];
      thirdFloor = [];
      forthFloor = [];
      print('response.body');
      print(response.body);
      allRooms.addAll(Rooms.fromJson(response.body).data);
      allRooms.forEach((element) {
        print("${element.roomNo} - ${element.isBooked}");
      });
      print(allRooms);
    } else {
      print('no data found');
    }
    print(allRooms);
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

  List<Data> available_room = [];

  Future availableRooms(String startDate, String endDate) async {
    print('enter the method of contorller----------');
    Response response = await RestDatasource.searchRooms(startDate, endDate);
    print(response.status.code);
    print(response.body);
    // ignore: unrelated_type_equality_checks
    if (response.status.code == 200) {
      available_room = [];
      print(
          'response.body dfsfaasdffaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaseeeeeeeeeeeeeeeeeeeeeeeeee');
      print("available room in hotel : ${response.body} ");

      available_room.addAll(Rooms.fromJson(response.body).data);
      // allRooms.forEach(
      //   (element) {
      //     print("${element.roomNo} - ${element.isBooked}");
      //   },
      // );
      print("available_rooms in this hotel : ${available_room}");
    } else {
      print('no data found');
    }
    print("all available rooms: ${available_room} ");

    update();
  }
}
