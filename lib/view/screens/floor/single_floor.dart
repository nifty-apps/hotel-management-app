import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samudra_bilash_hotel/controller/paging_controller.dart';
import 'package:samudra_bilash_hotel/controller/search_room_controller.dart';
import 'package:samudra_bilash_hotel/model/rooms_model.dart';
import 'package:samudra_bilash_hotel/view/screens/booking/booking.dart';

class SingleFloor extends StatefulWidget {
  final String floorNumber;
  SingleFloor({required this.floorNumber});
  @override
  _SingleFloorState createState() => _SingleFloorState();
}

class _SingleFloorState extends State<SingleFloor> {
  @override
  Widget build(BuildContext context) {
    Get.find<SearchroomController>().getAllRooms();
    print('build------------');
    List<Data> currentFloor = [];

    String fromDate = Get.find<SearchroomController>().fromSelectedDate;
    String toDate = Get.find<SearchroomController>().toSelectedDate;
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      fromDate + ' - ' + toDate,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Card(
                // width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    widget.floorNumber,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          GetBuilder<SearchroomController>(
            builder: (sercController) {
              if (widget.floorNumber == '1st Floor') {
                currentFloor = sercController.firstFloor;
              } else if (widget.floorNumber == '2nd Floor') {
                currentFloor = sercController.secondFloor;
              } else if (widget.floorNumber == '3rd Floor') {
                currentFloor = sercController.thirdFloor;
              } else {
                currentFloor = sercController.forthFloor;
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio:
                                4 / 2, //this is for resize the width and height
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    itemCount: currentFloor.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingRoom(
                                  room: currentFloor[index],
                                  fromDate: sercController.fromSelectedDate,
                                  toDate: sercController.toSelectedDate),
                            ),
                          );
                          Get.find<SearchroomController>().getAllRooms();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: currentFloor[index].isBooked != 0
                                ? currentFloor[index].isBooked == 2
                                    ? Colors.red
                                    : Colors.green
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  "Room No." +
                                      currentFloor[index].roomNo.toString(),
                                  style: TextStyle(
                                      color: currentFloor[index].isBooked != 0
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  currentFloor[index].name,
                                  style: TextStyle(
                                      color: currentFloor[index].isBooked != 0
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
