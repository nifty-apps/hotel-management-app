import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/room_controller.dart';
import 'package:somudro_bilash_hotel/model/room_type_model.dart';
import 'package:somudro_bilash_hotel/view/screens/rooms/rooms.dart';

class RoomTypeInfoTile extends StatelessWidget {
  final RoomType roomType;

  const RoomTypeInfoTile({
    Key? key,
    required this.roomType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          Get.find<RoomController>().roomTypeId = roomType.id;
          await Get.find<RoomController>().getRooms();
          Get.to(
            () => RoomsScreen(roomType: roomType),
          );
        },
        child: Container(
          padding: EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                roomType.name,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              Text(
                roomType.totalRooms.toString(),
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
