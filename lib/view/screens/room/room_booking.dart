import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/booking.dart';
import 'package:hotel_management/provider/room.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';
import 'package:intl/intl.dart';

class RoomBooking extends ConsumerStatefulWidget {
  final String roomId;
  RoomBooking({Key? key, required this.roomId}) : super(key: key);

  @override
  ConsumerState<RoomBooking> createState() => _RoomBookingState();
}

class _RoomBookingState extends ConsumerState<RoomBooking> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController rentController = TextEditingController();

  DateTime? checkIn;
  DateTime? checkOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).unfocus()),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 240,
              title: Text(
                'Room Booking',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Image.asset(
                    'assets/images/booking.png',
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: nameController,
                          inputType: TextInputType.text,
                          hintText: 'Name',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          controller: phoneController,
                          inputType: TextInputType.text,
                          hintText: 'Phone ',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          controller: addressController,
                          hintText: 'Address',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          controller: rentController,
                          hintText: 'Rent',
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () async {
                                  final date = await selectDate(context);
                                  setState(() {
                                    checkIn = date;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).hoverColor),
                                  height: 54,
                                  child: Center(
                                    child: Text(
                                      checkIn != null
                                          ? DateFormat.yMMMd().format(checkIn!)
                                          : 'Check Out',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () async {
                                  final date = await selectDate(context);
                                  setState(() {
                                    checkOut = date;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context).hoverColor,
                                  ),
                                  padding: EdgeInsets.only(left: 10),
                                  height: 54,
                                  child: Center(
                                    child: Text(
                                      checkOut != null
                                          ? DateFormat.yMMMd().format(checkOut!)
                                          : 'Check Out',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          onPressed: () async {
                            // Check if "check in" and "check out" date is not null
                            if (checkIn == null || checkOut == null) return;
                            Booking bookingData = Booking(
                              customer: Customer(
                                name: nameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                              ),
                              rent: int.parse(rentController.text),
                              checkIn: checkIn!,
                              checkOut: checkOut!,
                              room: null,
                            );
                            final result = await ref
                                .read(roomProvider)
                                .bookRoom(widget.roomId, bookingData, context);
                            if (result == true) {
                              Navigator.pushNamed(context, Routes.dashboard);
                            }
                          },
                          buttonText: 'Submit',
                          height: 48,
                          width: double.infinity,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: child!,
      ),
    );

    return pickedDate;
  }
}
