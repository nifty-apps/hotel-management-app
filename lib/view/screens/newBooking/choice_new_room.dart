import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/available_room.dart' as booking;
import 'package:hotel_management/models/booking_details.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:intl/intl.dart';

class ChoiceRoomScreen extends ConsumerStatefulWidget {
  final List<booking.AvailableRoom> availableRooms;
  final DateTime checkinDate;
  final DateTime checkoutDate;
  ChoiceRoomScreen({
    Key? key,
    required this.availableRooms,
    required this.checkinDate,
    required this.checkoutDate,
  }) : super(key: key);

  @override
  ConsumerState<ChoiceRoomScreen> createState() => _ChoiceRoomScreenState();
}

class _ChoiceRoomScreenState extends ConsumerState<ChoiceRoomScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.checkinDate);
    return Scaffold(
      appBar: AppBar(
        title: Text('Choice Room'),
      ),
      body: Padding(
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
                  Row(
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
                  SizedBox(height: 20),
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
                                  selectedItems.length.toString(),
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
                                  totalAmount.toString(),
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
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height / 2,
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
                    'Choice Room',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: widget.availableRooms.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ImageIcon(
                                        AssetImage('assets/icons/bed.png')),
                                    SizedBox(width: 14),
                                    Text(
                                      widget.availableRooms[index].type,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  thickness: 3,
                                ),
                                Container(
                                  height: 70,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget
                                        .availableRooms[index].rooms.length,
                                    itemBuilder: ((context, roomindex) {
                                      final room = widget.availableRooms[index]
                                          .rooms[roomindex];
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (selectedItems.contains(room)) {
                                              selectedItems.remove(room);
                                              totalAmount -= room.roomType.rent;
                                            } else {
                                              selectedItems.add(room);
                                              totalAmount += room.roomType.rent;
                                            }
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: selectedItems.contains(room)
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                            border: Border.all(
                                              color:
                                                  selectedItems.contains(room)
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                              width: 2,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              room.number,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    selectedItems.contains(room)
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                Divider(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  thickness: 3,
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.customerBookingInfo,
                    arguments: [
                      selectedItems,
                      widget.checkinDate,
                      widget.checkoutDate,
                      totalAmount
                    ]);
                selectedItems.forEach((element) {
                  roomId.add(element.id);
                });
                ref.read(bookingProvider).checkIn = widget.checkinDate;
                ref.read(bookingProvider).checkOut = widget.checkoutDate;
                ref.read(bookingProvider).allRoom = selectedItems;
                ref.read(bookingProvider).total = totalAmount;
              },
              buttonText: 'Next',
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }

  List<booking.Room> selectedItems = [];
  int totalAmount = 0;
  List<String> roomId = [];
}
