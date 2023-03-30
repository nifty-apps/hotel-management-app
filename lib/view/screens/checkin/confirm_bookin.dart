// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/available_room.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';

class ConfirmBookin extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    subTotal();
    payable();
    getRooms();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bookingStatus == PageType.checkin
              ? 'Confrim Check in'
              : bookingStatus == PageType.checkout
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
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      phone,
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
                        ...rooms.map(
                          (room) => TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(rooms.indexOf(room).toString()),
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
                      Text('TK. $discount'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Advance'),
                      Text('TK. $advance'),
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
                if (bookingStatus == PageType.confirm) {
                  bool isSuccess = await ref.read(bookingProvider).roomBooking(
                        name,
                        phone,
                        roomsId,
                        checkinDate.toIso8601String(),
                        checkoutDate.toIso8601String(),
                        total,
                        discount,
                        'booked',
                        context,
                      );
                  if (isSuccess) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.dashboard),
                        title: 'Successfully booked!',
                        buttonText: 'Back To Home',
                        imagePath: 'assets/icons/successful.png',
                      ),
                    );
                  }
                } else if (bookingStatus == PageType.checkin) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.dashboard),
                      title: 'Successfully checked in!',
                      buttonText: 'Back To Home',
                      imagePath: 'assets/icons/successful.png',
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.dashboard),
                      title: 'Successfully checked out!',
                      buttonText: 'Back To Home',
                      imagePath: 'assets/icons/successful.png',
                    ),
                  );
                }
              },
              buttonText: bookingStatus == PageType.checkin
                  ? 'Confrim Check in'
                  : bookingStatus == PageType.checkout
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
    for (var room in rooms) {
      total += room.rent;
    }
    print(total);
    return total;
  }

  int payableAmount = 0;
  payable() {
    payableAmount = total - discount - advance;
    print(payableAmount);
    return payableAmount;
  }

  List<String> roomsId = [];
  getRooms() {
    rooms.forEach((room) {
      roomsId.add(room.id);
    });
  }
}
