import 'package:get/get.dart';
import 'package:hotel_management/data/rest_ds.dart';
import 'package:hotel_management/model/room_type_model.dart';

class RoomTypeController extends GetxController implements GetxService {
  RoomTypeController() {
    getInfo(DateTime.now(), DateTime.now());
  }

  bool isLoading = false;

  List<RoomType> roomTypes = [];

  Future getInfo(DateTime startDate, DateTime endDate) async {
    isLoading = true;
    update();
    Response response = await RestDatasource.getRoomTypeInfo(
      startDate.toIso8601String(),
      endDate.toIso8601String(),
    );
    if (response.status.code == 200) {
      roomTypes.clear();
      response.body['data'].forEach((element) {
        roomTypes.add(RoomType.fromMap(element));
      });
    }
    isLoading = false;
    update();
  }
}
