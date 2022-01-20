import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/booking_controller.dart';
import 'package:somudro_bilash_hotel/controller/search_room_controller.dart';
import 'package:somudro_bilash_hotel/view/screens/booking/booking.dart';

class SearchRoomsScreen extends StatefulWidget {
  const SearchRoomsScreen({Key? key}) : super(key: key);

  @override
  _SearchRoomsScreenState createState() => _SearchRoomsScreenState();
}

class _SearchRoomsScreenState extends State<SearchRoomsScreen> {
  final bookingController = Get.put(BookingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: Text("Available Room"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: GetBuilder<SearchroomController>(
          builder: (sercController) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio:
                        4 / 2, //this is for resize the width and height
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemCount: sercController.available_room.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () async {
                      // await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => BookingRoom(
                      //         room: currentFloor[index],
                      //         fromDate: sercController.fromSelectedDate,
                      //         toDate: sercController.toSelectedDate),
                      //   ),
                      // );
                      //Get.find<SearchroomController>().getAllRooms();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingRoom(
                              room: sercController.available_room[index],
                              fromDate: sercController.fromSelectedDate,
                              toDate: sercController.toSelectedDate),
                        ),
                      );
                    },
                    child: Card(
                      child: Container(
                        // decoration: BoxDecoration(
                        //     boxShadow: [
                        //       BoxShadow(blurRadius: 20, color: Colors.black)
                        //     ],
                        //     borderRadius: BorderRadius.circular(15),
                        //     color: Colors.white),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                //sercController.available_room[index].isBooked ==1?
                                "Room No." +
                                    sercController.available_room[index].roomNo
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                sercController.available_room[index].name
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
