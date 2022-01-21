import 'package:get/get.dart';

class RoomTypeController extends GetxController implements GetxService {
  RoomTypeController() {
    getInfo();
  }

  bool isLoading = false;

  Map<String, int> roomInfo = {
    'All': 50,
    'Honeymoon Suite': 20,
    'Family Suite': 7,
    'Three Bed': 1,
    'Couple Bed': 9,
    'Twin Couple Bed(AC)': 10,
  };

  Future getInfo() async {
    isLoading = true;
    update();
    await Future.delayed(Duration(seconds: 3));
    // Response response = await RestDatasource.searchRooms(startDate, endDate);
    // print('Available rooms response body: ${response.body}');
    // if (response.status.code == 200) {
    //   availableRoom = [];
    //   availableRoom.addAll(Rooms.fromJson(response.body).data);
    // }
    // roomInfo = jsonDecode(response.body);
    isLoading = false;
    update();
  }
}
