import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:samudra_bilash_hotel/controller/booking_controller.dart';
import 'package:samudra_bilash_hotel/model/rooms_model.dart';
import 'package:samudra_bilash_hotel/view/screens/booking/booking_overview.dart';
import 'package:samudra_bilash_hotel/view/screens/floor/single_floor.dart';
import 'package:samudra_bilash_hotel/view/widgets/dashboard/date_range.dart';

class BookingRoom extends StatefulWidget {
  final Data room;
  final String fromDate;
  final String toDate;
  BookingRoom(
      {required this.room, required this.fromDate, required this.toDate});

  @override
  _BookingRoomState createState() => _BookingRoomState();
}

class _BookingRoomState extends State<BookingRoom> {
  String bookingStatus = '';
  String customerName = '';
  String customerPhone = '';
  String customerAddress = '';
  int roomFare = 0;
  int addvance = 0;

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
            bookController.roomId = widget.room.id;
            bookController.checkInDate = widget.fromDate;
            bookController.checkOutDate = widget.toDate;
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
                                  'Customer Name',
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
                                  'Customer Name',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20, top: 5),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  // cursorHeight: 40,
                                  onChanged: (String text) {
                                    bookController.name = text;
                                    print(bookController.name);
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    //labelText: 'User Name',
                                    hintText: 'Enter Customer Name',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
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
                                margin: EdgeInsets.only(right: 20, top: 5),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  // cursorHeight: 40,
                                  onChanged: (String text) {
                                    bookController.phone = int.parse(text);
                                    print(bookController.phone);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    //labelText: 'User Name',
                                    hintText: 'Enter Customer Phone Number',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(
                                  'Customer Address',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20, top: 5),
                                height: 70,
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  onChanged: (String text) {
                                    bookController.address = text;
                                    print(bookController.address);
                                  },
                                  // cursorHeight: 40,
                                  maxLines: 4,
                                  keyboardType: TextInputType.text,

                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 15, left: 10),
                                    border: OutlineInputBorder(),
                                    //labelText: 'User Name',

                                    hintText: 'Write customer address',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(
                                  'Room Fare',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20, top: 10),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  onChanged: (String text) {
                                    bookController.roomFare = int.parse(text);
                                    print(bookController.roomFare);
                                  },
                                  keyboardType: TextInputType.number,
                                  // cursorHeight: 40,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    //labelText: 'User Name',
                                    hintText: 'Write room fare',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(
                                  'Advance pay',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20, top: 10),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  onChanged: (String text) {
                                    bookController.advanceRoomFare =
                                        int.parse(text);
                                    print(bookController.name);
                                    if (bookController.advanceRoomFare ==
                                        bookController.roomFare) {
                                      bookController.isPaid = 1;
                                    } else {
                                      bookController.isPaid = 0;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  // cursorHeight: 40,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    //labelText: 'User Name',
                                    hintText: 'Write advance pay',
                                  ),
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
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (bookingStatus == '') {
                                bookingStatus = 'booked';
                                bookController.bookingStatus = 'booked';
                              } else {
                                bookingStatus = '';
                                bookController.bookingStatus = '';
                              }
                            });
                          },
                          child: Container(
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
                                  color: bookingStatus != ''
                                      ? Colors.red
                                      : Colors.white),
                            ),
                          ),
                        )
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookingOverView(room: widget.room),
                                  ),
                                );
                               
                             
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  color: Colors.green,
                                ),
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Center(
                                  child: Text(
                                    'Overview',
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
