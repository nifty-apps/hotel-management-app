import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:somudro_bilash_hotel/controller/booking_controller.dart';
import 'package:somudro_bilash_hotel/controller/transactionController.dart';
import 'package:somudro_bilash_hotel/model/booking_model.dart';
import 'package:somudro_bilash_hotel/model/room_model.dart';
import 'package:somudro_bilash_hotel/view/screens/booking_edit/booking_edit_page.dart';
import 'package:somudro_bilash_hotel/view/screens/transaction/transacionView_page.dart';

class BookingOverview extends StatefulWidget {
  final Room room;
  BookingOverview({Key? key, required this.room}) : super(key: key);

  @override
  State<BookingOverview> createState() => _BookingOverviewState();
}

class _BookingOverviewState extends State<BookingOverview> {
  final keyStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black54);

  final valueStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${widget.room.roomNo} - ${widget.room.name}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: Get.find<BookingController>().getBookingDetails(widget.room.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Booking> bookings = snapshot.data;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 8.0,
              ),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.find<TransactionController>().getTransactions(
                            bookings[index].id!,
                          );
                          Get.to(() => TransactionView());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.00),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  splashRadius: 20.0,
                                  iconSize: 20.0,
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    await Get.to(
                                      () => BookingEditPage(
                                        booking: bookings[index].copyWith(
                                          roomId: widget.room.id,
                                        ),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        'Booking ID: ',
                                        style: keyStyle,
                                      ),
                                      Text(
                                        bookings[index].id.toString(),
                                        style: valueStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Wrap(
                                    children: [
                                      Text(
                                        'Customer Name: ',
                                        style: keyStyle,
                                      ),
                                      Text(
                                        bookings[index].name.toString(),
                                        style: valueStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Wrap(
                                    children: [
                                      Text(
                                        'Phone Number: ',
                                        style: keyStyle,
                                      ),
                                      Text(
                                        bookings[index].phone.toString(),
                                        style: valueStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Wrap(
                                    children: [
                                      Text(
                                        'Address: ',
                                        style: keyStyle,
                                      ),
                                      Text(
                                        bookings[index].address,
                                        style: valueStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Wrap(
                                    children: [
                                      Text(
                                        'Booking Status: ',
                                        style: keyStyle,
                                      ),
                                      Text(
                                        bookings[index]
                                            .bookingStatus
                                            .toString(),
                                        style: valueStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Wrap(
                                    children: [
                                      Text(
                                        'Total fare: ',
                                        style: keyStyle,
                                      ),
                                      Text(
                                        bookings[index].roomFare.toString(),
                                        style: valueStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Wrap(
                                    children: [
                                      Text(
                                        'Check In: ',
                                        style: keyStyle,
                                      ),
                                      Text(
                                        DateFormat(DateFormat.ABBR_MONTH_DAY)
                                            .add_jm()
                                            .format(
                                              DateTime.parse(
                                                bookings[index]
                                                    .checkInDate
                                                    .toString(),
                                              ),
                                            ),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Wrap(
                                    children: [
                                      Text(
                                        'Check Out: ',
                                        style: keyStyle,
                                      ),
                                      Text(
                                        DateFormat(DateFormat.ABBR_MONTH_DAY)
                                            .add_jm()
                                            .format(
                                              DateTime.parse(
                                                bookings[index]
                                                    .checkOutDate
                                                    .toString(),
                                              ),
                                            ),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: SpinKitThreeBounce(
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
