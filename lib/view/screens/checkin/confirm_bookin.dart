// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/available_room.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';

class ConfirmBookin extends ConsumerStatefulWidget {
  final PageType bookingStatus;
  final DateTime checkinDate;
  final DateTime checkoutDate;
  final String name;
  final String phone;
  final int discount;
  final int advance;
  final List<Room> rooms;
  ConfirmBookin({
    Key? key,
    required this.bookingStatus,
    required this.checkinDate,
    required this.checkoutDate,
    required this.name,
    required this.phone,
    required this.discount,
    required this.advance,
    required this.rooms,
  }) : super(key: key);

  @override
  ConsumerState<ConfirmBookin> createState() => _ConfirmBookinState();
}

class _ConfirmBookinState extends ConsumerState<ConfirmBookin> {
  @override
  void initState() {
    super.initState();
    getRooms();
    subTotal();
    payable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.bookingStatus == PageType.checkin
              ? 'Confrim Check in'
              : widget.bookingStatus == PageType.checkout
                  ? 'Checkout'
                  : 'Confirm',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 16,
              ),
              height: MediaQuery.of(context).size.height / 6.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 60,
                    ),
                    title: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      widget.phone,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Theme.of(context).colorScheme.background,
                    thickness: 3,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              // height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bill Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Table(
                      border: TableBorder.all(width: 1.0, color: Colors.grey),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Color(0xFFA5A9BB)),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Serial'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Type'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Rent'),
                              ),
                            ),
                          ],
                        ),
                        ...widget.rooms.map(
                          (room) => TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      widget.rooms.indexOf(room).toString()),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Single Room'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(room.rent.toString()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total'),
                      Text('TK. $total'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount'),
                      Text('TK. ${widget.discount}'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Advance'),
                      Text('TK. ${widget.advance}'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payable',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'TK. $payableAmount',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
              onPressed: () async {
                bool isSuccess = await ref.read(bookingProvider).roomBooking(
                      widget.name,
                      widget.phone,
                      roomsId,
                      widget.checkinDate.toIso8601String(),
                      widget.checkoutDate.toIso8601String(),
                      total,
                      widget.discount,
                      widget.bookingStatus == PageType.confirm
                          ? 'booked'
                          : widget.bookingStatus == PageType.checkin
                              ? 'checkIn'
                              : 'checkOut',
                      context,
                    );
                if (isSuccess) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.dashboard),
                      title: widget.bookingStatus == PageType.confirm
                          ? 'Successfully booked!'
                          : widget.bookingStatus == PageType.checkin
                              ? 'Successfully checked in!'
                              : 'Successfully checked out!',
                      buttonText: 'Back To Home',
                      imagePath: 'assets/icons/successful.png',
                    ),
                  );
                }
              },
              buttonText: widget.bookingStatus == PageType.checkin
                  ? 'Confrim Check in'
                  : widget.bookingStatus == PageType.checkout
                      ? 'Checkout'
                      : 'Confirm',
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  int total = 0;

  subTotal() {
    for (var room in widget.rooms) {
      total += room.rent;
    }
    return total;
  }

  int payableAmount = 0;

  payable() {
    payableAmount = total - widget.discount - widget.advance;
    return payableAmount;
  }

  List<String> roomsId = [];

  getRooms() {
    widget.rooms.forEach((room) {
      roomsId.add(room.id);
    });
  }
}
