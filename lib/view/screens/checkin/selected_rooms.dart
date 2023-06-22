// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/available_room.dart' as booking;
import 'package:hotel_management/models/transaction.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/transaction.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/view/base/custom_button.dart';

class SelectedRooms extends ConsumerStatefulWidget {
  final String bookingId;
  SelectedRooms({
    Key? key,
    required this.bookingId,
  }) : super(key: key);

  @override
  ConsumerState<SelectedRooms> createState() => _SelectedRoomsState();
}

class _SelectedRoomsState extends ConsumerState<SelectedRooms> {
  List<String> roomsId = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(bookingProvider).getBookingDetails(id: widget.bookingId);
      getRooms();
      await ref
          .read(transactionProvider)
          .getTransactionList(widget.bookingId, true);
      final bookingDetails = ref.read(bookingProvider).bookingDetails;
      ref.read(bookingProvider).nameController.text =
          bookingDetails.customer.name;
      ref.read(bookingProvider).phoneController.text =
          bookingDetails.customer.phone;
      ref.read(bookingProvider).phoneController.text =
          bookingDetails.customer.phone;
      ref.read(bookingProvider).discountController.text =
          bookingDetails.discount.toString();
      ref.read(bookingProvider).checkIn = bookingDetails.checkIn;
      ref.read(bookingProvider).checkIn = bookingDetails.checkOut;
      ref.read(bookingProvider).allRoom =
          bookingDetails.rooms.cast<booking.Room>();
      ref.read(bookingProvider).status = bookingDetails.status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: ref.watch(bookingProvider).isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            ref
                                .read(bookingProvider)
                                .bookingDetails
                                .customer
                                .name,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(ref
                              .read(bookingProvider)
                              .bookingDetails
                              .customer
                              .phone),
                          leading: Icon(
                            Icons.person,
                            size: 40,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Rooms',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage('assets/icons/bed.png'),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        ref
                                            .read(bookingProvider)
                                            .bookingDetails
                                            .rooms
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 3,
                              color: Theme.of(context).colorScheme.background,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/tk.png',
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        ref
                                            .read(bookingProvider)
                                            .bookingDetails
                                            .total
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.background,
                          thickness: 3,
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_month),
                            SizedBox(width: 5),
                            Text(
                              '${DateFormat('dd EEE, MMM yyyy', 'en_US').format(ref.read(bookingProvider).bookingDetails.checkIn.toLocal())} to ${DateFormat('dd EEE, MMM yyyy', 'en_US').format(ref.read(bookingProvider).bookingDetails.checkOut.toLocal())}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.updateBooking,
                                    arguments: [
                                      widget.bookingId,
                                      ref
                                          .read(bookingProvider)
                                          .bookingDetails
                                          .checkOut
                                          .toLocal(),
                                      roomsId
                                    ]);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'Selected Room',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.background,
                          thickness: 3,
                        ),
                        Container(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ref
                                .read(bookingProvider)
                                .bookingDetails
                                .rooms
                                .length,
                            itemBuilder: ((context, roomindex) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          ref
                                                  .read(bookingProvider)
                                                  .bookingDetails
                                                  .rooms[roomindex]
                                                  .roomType
                                                  .type
                                                  .contains('Room')
                                              ? ref
                                                  .read(bookingProvider)
                                                  .bookingDetails
                                                  .rooms[roomindex]
                                                  .roomType
                                                  .type
                                                  .replaceAll('Room', '')
                                              : ref
                                                  .read(bookingProvider)
                                                  .bookingDetails
                                                  .rooms[roomindex]
                                                  .roomType
                                                  .type,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          ref
                                              .read(bookingProvider)
                                              .bookingDetails
                                              .rooms[roomindex]
                                              .number
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.background,
                          thickness: 3,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    onPressed: () async {
                      final double data = getTotalAdvanceAmount(
                          ref.read(transactionProvider).transaction);
                      int payable = (ref
                              .read(bookingProvider)
                              .bookingDetails
                              .total -
                          ref.read(bookingProvider).bookingDetails.discount);
                      if (payable == data.toInt()) {
                        Navigator.pushNamed(
                          context,
                          Routes.confirmCheckin,
                          arguments: [
                            PageType.checkin,
                          ],
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          Routes.payment,
                          arguments: data.toInt(),
                        );
                      }
                    },
                    buttonText: 'Next',
                    width: double.infinity,
                  )
                ],
              ),
            ),
    );
  }

  getTotalAdvanceAmount(List<Transaction> transactions) {
    double total = 0;
    for (var i = 0; i < transactions.length; i++) {
      total += transactions[i].amount;
    }
    return total;
  }

  getRooms() {
    ref.watch(bookingProvider).allRoom.forEach((room) {
      roomsId.add(room.id);
    });
    print(roomsId);
  }
}
