import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/view/screens/rooms/rooms.dart';

class RoomTypeInfoTile extends StatelessWidget {
  final String roomType;
  final int roomAvailable;

  const RoomTypeInfoTile({
    Key? key,
    required this.roomType,
    required this.roomAvailable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Get.to(() => RoomsScreen());
        },
        child: Container(
          padding: EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                roomType,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              Text(
                roomAvailable.toString(),
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
