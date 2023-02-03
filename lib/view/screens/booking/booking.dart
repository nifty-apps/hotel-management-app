import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/room_model.dart';

class BookingRoom extends StatefulWidget {
  final Room room;
  final DateTime fromDate;
  final DateTime toDate;

  BookingRoom({
    required this.room,
    required this.fromDate,
    required this.toDate,
  });

  @override
  _BookingRoomState createState() => _BookingRoomState();
}

class _BookingRoomState extends State<BookingRoom> {
  String bookingStatus = '';
  String customerName = '';
  String customerPhone = '';
  String customerAddress = '';
  int roomFare = 0;
  int advance = 0;
  // Initial Selected Value
  String dropdownvalue = 'booked';

  // List of items in our dropdown menu
  final roomStatuses = {
    'check_in': 'Check In',
    'booked': 'Booked',
  };

  // final bookingController = Get.put(BookingController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.room.roomNo} - ${widget.room.name}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (c, d, _) {
            // bookController.roomId = widget.room.id;
            // bookController.checkInDate = widget.fromDate;
            // bookController.checkOutDate = widget.toDate;
            return Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: (String text) {
                        // bookController.name = text;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
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
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onChanged: (String text) {
                        // bookController.phone = text.trim();
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Customer Phone Number',
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onChanged: (String text) {
                        // bookController.address = text;
                      },
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your room fare';
                        }
                        return null;
                      },
                      onChanged: (String text) {
                        // bookController.roomFare = int.parse(text);
                      },
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write room fare',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        'Paid amount',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your paid amount';
                        }
                        return null;
                      },
                      onChanged: (String text) {
                        // bookController.paidAmount = int.parse(text);
                      },
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write paid amount',
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
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      // Array list of items
                      items: roomStatuses.keys.map((key) {
                        return DropdownMenuItem(
                          value: key,
                          child: Text(roomStatuses[key]!),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          // dropdownvalue = newValue!;
                          // bookingController.bookingStatus = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // if (await bookingController.bookRoom()) {
                          //   Get.find<RoomController>().getRooms();
                          //   Get.back(closeOverlays: true);
                          //   Get.snackbar(
                          //     'Success',
                          //     'Room confirm successfuly',
                          //     snackPosition: SnackPosition.BOTTOM,
                          //   );
                          // } else {
                          //   Get.snackbar(
                          //     'Error',
                          //     'Something went wrong!',
                          //     snackPosition: SnackPosition.BOTTOM,
                          //   );
                          // }
                        }
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 14.0,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
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
  }
}
