// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/room_booking.dart' as booking;
import 'package:hotel_management/models/room_booking.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/transaction.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';

class ConfirmBookin extends ConsumerStatefulWidget {
  final PageType bookingStatus;
  final bool checkinNow;

  ConfirmBookin(
      {Key? key, required this.bookingStatus, required this.checkinNow})
      : super(key: key);

  @override
  ConsumerState<ConfirmBookin> createState() => _ConfirmBookinState();
}

class _ConfirmBookinState extends ConsumerState<ConfirmBookin> {
  @override
  void initState() {
    super.initState();
    getRooms();
    subTotal();
    getTotalAdvanceAmount();
    payable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.bookingStatus == PageType.checkin
              ? 'Confrim Checkin'
              : widget.bookingStatus == PageType.checkout
                  ? 'Confirm Checkout'
                  : 'Booking Confirm',
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
                      ref.read(bookingProvider).nameController.text,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      ref.read(bookingProvider).phoneController.text,
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
                        ...ref.read(bookingProvider).allRoom.map(
                              (room) => TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(ref
                                          .read(bookingProvider)
                                          .allRoom
                                          .indexOf(room)
                                          .toString()),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(room.roomType.type),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child:
                                          Text(room.roomType.rent.toString()),
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
                      Text(
                          'TK. ${ref.read(bookingProvider).discountController.text.toString()}'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Advance'),
                      Text(
                          'TK. ${advancAmount != 0 ? advancAmount.toString() : ref.read(bookingProvider).advanceController.text.toString()}'),
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
                booking.Customer customer = booking.Customer(
                  name: ref.read(bookingProvider).nameController.text,
                  phone: ref.read(bookingProvider).phoneController.text,
                );
                RoomBooking bookingInfo = RoomBooking(
                  customer: customer,
                  rooms: roomsId,
                  checkIn: ref.read(bookingProvider).checkIn!.toUtc(),
                  checkOut: ref.read(bookingProvider).checkOut!.toUtc(),
                  total: total,
                  discount: int.parse(
                      ref.read(bookingProvider).discountController.text),
                  status: widget.bookingStatus == PageType.confirm
                      ? 'booked'
                      : widget.bookingStatus == PageType.checkin
                          ? 'checkedIn'
                          : 'checkedOut',
                  paymentStatus: payableAmount == 0 || payableAmount < 0
                      ? 'paid'
                      : 'unpaid',
                );
                if (widget.bookingStatus == PageType.confirm ||
                    widget.checkinNow == true) {
                  String? bookingId =
                      await ref.read(bookingProvider).roomBooking(
                            bookingInfo,
                            context,
                          );
                  if (bookingId != null) {
                    await ref.read(transactionProvider).addTransaction(
                          context,
                          paymentMethod: 'cash',
                          bookingId: bookingId,
                          amount: int.parse(
                            ref.read(bookingProvider).advanceController.text,
                          ),
                        );
                  }
                } else {
                  await ref.read(bookingProvider).updateBookingStatus(
                        id: ref.read(bookingProvider).bookingDetails.id,
                        status: widget.bookingStatus == PageType.checkin
                            ? 'checkedIn'
                            : 'checkedOut',
                      );
                }
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    onTap: () => Navigator.pushNamed(context, Routes.dashboard),
                    title: widget.bookingStatus == PageType.confirm
                        ? 'Successfully booked!'
                        : widget.bookingStatus == PageType.checkin
                            ? 'Successfully checked in!'
                            : 'Successfully checked out!',
                    buttonText: 'Back To Home',
                    imagePath: 'assets/icons/successful.png',
                  ),
                );
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
    for (var room in ref.read(bookingProvider).allRoom) {
      total += room.roomType.rent;
    }
    return total;
  }

  List<String> roomsId = [];

  getRooms() {
    ref.read(bookingProvider).allRoom.forEach((room) {
      roomsId.add(room.id);
    });
  }

  int advancAmount = 0;
  getTotalAdvanceAmount() {
    for (var i = 0; i < ref.read(transactionProvider).transaction.length; i++) {
      advancAmount += ref.read(transactionProvider).transaction[i].amount;
    }
    return advancAmount;
  }

  int payableAmount = 0;

  payable() {
    if (widget.bookingStatus == PageType.confirm ||
        widget.bookingStatus == PageType.checkin) {
      int amount =
          int.parse(ref.read(bookingProvider).discountController.text) +
              int.parse(ref.read(bookingProvider).advanceController.text);
      payableAmount = total - amount;
    } else {
      int amount =
          int.parse(ref.read(bookingProvider).discountController.text) +
              advancAmount;
      payableAmount = total - amount;
    }

    return payableAmount;
  }
}
