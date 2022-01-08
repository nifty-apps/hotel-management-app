import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samudra_bilash_hotel/controller/booking_controller.dart';
import 'package:samudra_bilash_hotel/controller/search_room_controller.dart';
import 'package:samudra_bilash_hotel/model/rooms_model.dart';

class BookingOverView extends StatefulWidget {
  final Data room;
  BookingOverView({required this.room});

  @override
  _BookingOverViewState createState() => _BookingOverViewState();
}

class _BookingOverViewState extends State<BookingOverView> {
  String bookingStatus = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            widget.room.isBooked != 0 ? Colors.green : Colors.grey[300],
        title: Container(
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  widget.room.roomNo.toString(),
                  style: TextStyle(
                      color: widget.room.isBooked != 0
                          ? Colors.white
                          : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(
                  widget.room.name,
                  style: TextStyle(
                      color: widget.room.isBooked != 0
                          ? Colors.white
                          : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<BookingController>(
          builder: (bookController) {
            return Container(
              padding: EdgeInsets.only(top: 24),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.room.isBooked != 0
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  'Customer Name: ${bookController.name}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text('Customer Name',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600))),
                              Container(
                                child: Text(
                                  'Customer phone',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  // margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text('01XXXXXXXXXX',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600))),
                            ],
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  'Customer Name: ${bookController.name}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(
                                  'Customer phone: ${bookController.phone}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(
                                  'Customer Address: ${bookController.address} ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(
                                  'Room Fare: ${bookController.roomFare}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(
                                  'Advance pay: ${bookController.advanceRoomFare}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Row(
                      children: [
                        Container(
                            child: Text(
                          'Booking Status',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          // padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            // color: Colors.green,
                          ),
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: bookController.bookingStatus != ''
                                    ? Colors.red
                                    : Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.room.isBooked != 0
                      ? Container(
                          child: Center(
                            child: InkWell(
                              child: Container(
                                //  padding: EdgeInsets.all(10),
                                height: 50,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  color: Colors.red,
                                ),
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Center(
                                  child: Text(
                                    'Book Cancel',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Get.find<BookingController>()
                                    .bookRoom()
                                    .then((value) {
                                  print(
                                      "--------------------Loading------------------");
                                  Get.find<SearchroomController>()
                                      .getAllRooms();
                                });
                                Navigator.popUntil(
                                    context, ModalRoute.withName("/home"));
                              },
                              child: Container(
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  color: Colors.green,
                                ),
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Center(
                                  child: Text(
                                    'Booking Confirm',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
