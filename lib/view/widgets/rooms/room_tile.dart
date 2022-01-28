import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/model/rooms_model.dart';
import 'package:somudro_bilash_hotel/view/screens/booking/booking.dart';
import 'package:somudro_bilash_hotel/view/screens/booking/booking_overview.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({
    Key? key,
    required this.room,
    required this.fromDate,
    required this.toDate,
  }) : super(key: key);

  final Room room;
  final DateTime fromDate;
  final DateTime toDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: room.isBooked == 0
          ? Colors.white
          : room.isBooked == 1
              ? Colors.green
              : Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () async {
          if (room.isBooked == 1) {
            Get.to(() => BookingOverview(room: room));
          } else {
            Get.to(
              () => BookingRoom(
                room: room,
                fromDate: fromDate,
                toDate: toDate,
              ),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Room No ' + room.roomNo.toString(),
                style: TextStyle(
                  color: room.isBooked == 0
                      ? Colors.black
                      : room.isBooked == 1
                          ? Colors.white
                          : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                room.name,
                style: TextStyle(
                  color: room.isBooked == 0
                      ? Colors.black
                      : room.isBooked == 1
                          ? Colors.white
                          : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
