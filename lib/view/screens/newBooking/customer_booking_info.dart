// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/available_room.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';
import 'package:intl/intl.dart';

class CustomerBookingInfoScreen extends ConsumerStatefulWidget {
  final List<Room> rooms;
  final DateTime checkinDate;
  final DateTime checkoutDate;
  final int amount;
  CustomerBookingInfoScreen({
    Key? key,
    required this.rooms,
    required this.checkinDate,
    required this.checkoutDate,
    required this.amount,
  }) : super(key: key);

  @override
  ConsumerState<CustomerBookingInfoScreen> createState() =>
      _CustomerBookingInfoScreenState();
}

class _CustomerBookingInfoScreenState
    extends ConsumerState<CustomerBookingInfoScreen> {
  bool isCheckin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Booking Info'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(width: 10),
                      Text(
                        '${DateFormat('d EEE,MMM yy').format(widget.checkinDate)} to ${DateFormat('d EEE,MMM yy').format(widget.checkoutDate)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Container(
                      height: 70,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Rooms',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Image.asset('assets/icons/tk.png'),
                                      SizedBox(width: 10),
                                      Text(
                                        widget.rooms.length.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            thickness: 1,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Amount',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Image.asset('assets/icons/tk.png'),
                                        SizedBox(width: 10),
                                        Text(
                                          widget.amount.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.background,
                    thickness: 3,
                    indent: 16,
                    endIndent: 16,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        CustomTextFormField(
                          controller: ref.read(bookingProvider).nameController,
                          hintText: 'Enter customer name',
                          labelText: 'Customer Name',
                          keyboardType: TextInputType.text,
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(height: 30),
                        CustomTextFormField(
                          controller: ref.read(bookingProvider).phoneController,
                          hintText: 'Enter phone number',
                          labelText: 'Phone Number',
                          keyboardType: TextInputType.number,
                          prefixIcon: Icons.phone_android,
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 63,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Container(
                                  height: 70,
                                  width: 220,
                                  child: 
                                  CustomTextFormField(
                                    controller: ref
                                        .read(bookingProvider)
                                        .discountController,
                                    hintText: 'Enter amount',
                                    labelText: 'Discount',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA5A9BB),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Discount Amount',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        CustomTextFormField(
                          controller:
                              ref.read(bookingProvider).advanceController,
                          hintText: 'Enter amount',
                          labelText: 'Advance Amount',
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Checkbox(
                                value: isCheckin,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckin = value!;
                                  });
                                }),
                            Text(
                              'Checkin now?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        CustomButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.confirmCheckin, arguments: [
                              isCheckin ? PageType.checkin : PageType.confirm,
                              isCheckin
                            ]);
                          },
                          buttonText: 'Next',
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
}
