import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/booking_controller.dart';
import 'package:somudro_bilash_hotel/model/booking_model.dart';

class BookingEditPage extends StatefulWidget {
  BookingEditPage({
    Key? key,
    required this.booking,
  }) : super(key: key);
  final Booking booking;

  @override
  State<BookingEditPage> createState() => _BookingEditPageState();
}

class _BookingEditPageState extends State<BookingEditPage> {
  final formKey = GlobalKey<FormState>();

  // List of items in our dropdown menu
  final roomStatuses = {
    'booked': 'Booked',
    'check_in': 'Check In',
    'check_out': 'Check Out',
    'cancel': 'Cancel'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Customer Name',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: widget.booking.name,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please enter your name';
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Customer Name',
                ),
                onChanged: (String name) {
                  widget.booking.name = name;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Customer phone',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: widget.booking.phone.toString(),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Customer Phone Number',
                ),
                onChanged: (String number) {
                  widget.booking.phone = number;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Customer Address',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: widget.booking.address,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please enter your address';
                  }
                },
                maxLines: 4,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write customer address',
                ),
                onChanged: (String address) {
                  widget.booking.address = address;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Total fare',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: widget.booking.roomFare.toString(),
                keyboardType: TextInputType.number,
                maxLines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Total Fare';
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write total fare',
                ),
                onChanged: (String amount) {
                  widget.booking.roomFare = int.parse(amount);
                },
              ),
              SizedBox(height: 5),
              Text(
                'Check In Date',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: widget.booking.checkInDate,
                keyboardType: TextInputType.number,
                maxLines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Check in date';
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'check in date',
                ),
                onChanged: (String checkInDate) {
                  widget.booking.checkInDate = checkInDate;
                },
              ),
              SizedBox(height: 5),
              Text(
                'Check Out Date',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: widget.booking.checkOutDate,
                keyboardType: TextInputType.number,
                maxLines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Check out date';
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'check out date',
                ),
                onChanged: (String checkOutDate) {
                  widget.booking.checkOutDate = checkOutDate;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Booking Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              DropdownButton(
                // Initial Value
                value: widget.booking.bookingStatus,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: roomStatuses.keys.map((key) {
                  return DropdownMenuItem(
                    value: key,
                    child: Text(roomStatuses[key]!),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.booking.bookingStatus = newValue!;
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    bool success = await Get.find<BookingController>()
                        .updateBooking(widget.booking);
                    if (success) {
                      Get.back(closeOverlays: true);
                      Get.snackbar(
                        'Success',
                        'Successfully Updated!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      Get.snackbar(
                        'Error',
                        'Update unsuccessful',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  }
                },
                child: Text(
                  'Update',
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
      )),
    );
  }
}
