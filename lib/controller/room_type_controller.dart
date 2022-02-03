import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/data/rest_ds.dart';
import 'package:somudro_bilash_hotel/model/room_type_model.dart';

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
