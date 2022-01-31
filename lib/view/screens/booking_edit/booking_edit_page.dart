import 'package:flutter/material.dart';
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

  // Initial Selected Value
  String dropdownvalue = 'check_in';

  // List of items in our dropdown menu
  final roomStatuses = {
    'check_in': 'Check In',
    'check_out': 'Check Out',
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
                initialValue: widget.booking.customerName,
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
                  // widget.booking!.customerName = name;
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
                initialValue: '01795685256',
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
                  // widget.booking!.customerName = number;
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
                initialValue: 'Dhaka',
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
                onChanged: (String address) {},
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
                initialValue: '18000',
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
                onChanged: (String paidAmount) {},
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
                initialValue: '12/21/2021',
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
                onChanged: (String paidAmount) {},
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
                initialValue: '12/21/2021',
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
                onChanged: (String paidAmount) {},
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

                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {}
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
