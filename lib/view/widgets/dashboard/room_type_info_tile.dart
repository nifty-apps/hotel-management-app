import 'package:flutter/material.dart';

class RoomTypeInfoTile extends StatelessWidget {


  const RoomTypeInfoTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          // Get.find<RoomController>().roomTypeId = roomType.id;
          // await Get.find<RoomController>().getRooms();
          // Get.to(
          //   () => RoomsScreen(roomType: roomType),
          // );
        },
        child: Container(
          padding: EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "roomType.name",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              Text(
                "roomType.totalRooms",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
