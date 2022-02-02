import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/model/room_model.dart';
import 'package:somudro_bilash_hotel/view/screens/booking/booking.dart';
import 'package:somudro_bilash_hotel/view/screens/booking/booking_overview.dart';

class RoomTile extends StatefulWidget {
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
  State<RoomTile> createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.room.isBooked == 0
          ? Colors.white
          : widget.room.isBooked == 1
              ? Colors.green
              : Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () async {
          if (widget.room.isBooked == 0) {
            await Get.to(
              () => BookingRoom(
                room: widget.room,
                fromDate: widget.fromDate,
                toDate: widget.toDate,
              ),
            );
            setState(() {});
          } else {
            await Get.to(() => BookingOverview(room: widget.room));
            setState(() {});
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Room No ' + widget.room.roomNo.toString(),
                style: TextStyle(
                  color: widget.room.isBooked == 0
                      ? Colors.black
                      : widget.room.isBooked == 1
                          ? Colors.white
                          : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                widget.room.name,
                style: TextStyle(
                  color: widget.room.isBooked == 0
                      ? Colors.black
                      : widget.room.isBooked == 1
                          ? Colors.white
                          : Colors.white,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                widget.room.haveAc == 1 ? 'AC' : 'Non-AC',
                style: TextStyle(
                  color: widget.room.isBooked == 0
                      ? Colors.black
                      : widget.room.isBooked == 1
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
