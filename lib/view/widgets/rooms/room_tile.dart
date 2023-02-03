import 'package:flutter/material.dart';
import 'package:hotel_management/models/room_model.dart';

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
            // Get.to(
            //   () => BookingRoom(
            //     room: widget.room,
            //     fromDate: widget.fromDate,
            //     toDate: widget.toDate,
            //   ),
            // );
          } else {
            // Get.to(() => BookingOverview(
            //       room: widget.room,
            //     ));
          }
        },
        child: Container(
          margin: EdgeInsets.all(5.0),
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
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                widget.room.name,
                style: TextStyle(
                  color: widget.room.isBooked == 0
                      ? Colors.black
                      : widget.room.isBooked == 1
                          ? Colors.white
                          : Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.0),
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
