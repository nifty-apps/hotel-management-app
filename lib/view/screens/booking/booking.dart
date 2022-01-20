import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/booking_controller.dart';
import 'package:somudro_bilash_hotel/model/rooms_model.dart';

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
  // Initial Selected Value
  String dropdownvalue = 'Check in';

  // List of items in our dropdown menu
  var items = ["Check in", "Check out"];
  final bookingController = Get.put(BookingController());
  // @override
  // void initState() {
  //   bookingController.bookRoom();
  //   print(bookingController.bookRoom());
  //   super.initState();
  // }
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        elevation: 2,
        backgroundColor:
            widget.room.isBooked != 0 ? Colors.green : Colors.white,
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
                                // Container(
                                //   child: Text(
                                //     'Customer Name',
                                //     style: TextStyle(
                                //         color: Colors.black,
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
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
                            margin:
                                EdgeInsets.only(top: 10, left: 20, right: 10),
                            child: Form(
                              key: formKey,
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
                                  TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your name";
                                      }
                                    },
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
                                  TextFormField(
                                    // cursorHeight: 40,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your phone number";
                                      }
                                    },
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //////////////////////////////
                                  Container(
                                    child: Text(
                                      'Customer Address',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your address";
                                      }
                                    },
                                    onChanged: (String text) {
                                      bookController.address = text;
                                      print(bookController.address);
                                    },
                                    // cursorHeight: 40,
                                    maxLines: 4,
                                    keyboardType: TextInputType.text,

                                    decoration: InputDecoration(
                                      // contentPadding: EdgeInsets.only(
                                      //     top: 15, left: 10),
                                      border: OutlineInputBorder(),
                                      //labelText: 'User Name',

                                      hintText: 'Write customer address',
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
                                  TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your room fare";
                                      }
                                    },
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: Text(
                                      'Paid ammount',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your paid ammount";
                                      }
                                    },
                                    onChanged: (String text) {
                                      bookController.paidAmmount =
                                          int.parse(text);
                                      // print(bookController.name);
                                      // if (bookController.paidAmmount ==
                                      //     bookController.roomFare) {
                                      //   bookController.isPaid = 1;
                                      // } else {
                                      //   bookController.isPaid = 0;
                                      // }
                                    },
                                    keyboardType: TextInputType.number,
                                    // cursorHeight: 40,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      //labelText: 'User Name',
                                      hintText: 'Write paid ammount',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Container(
                                    child: Text(
                                      'Booking Status',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  DropdownButton(
                                    // Initial Value
                                    value: dropdownvalue,

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                        bookingController.bookingStatus =
                                            newValue;
                                      });
                                    },
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                  color: Colors.red,
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Center(
                                                  child: Text(
                                                    'Book Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         BookingOverView(
                                                  //             room:
                                                  //                 widget.room),
                                                  //   ),
                                                  // );
                                                  bookingController.bookRoom();
                                                  Get.snackbar("Confirm",
                                                      "Room confirm successfuly");
                                                  return null;
                                                }
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                  color: Colors.green,
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Center(
                                                  child: Text(
                                                    'Confirm',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          )
                  ]),
            );
          },
        ),
      ),
    );
  }
}
