import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:somudro_bilash_hotel/controller/booking_controller.dart';
import 'package:somudro_bilash_hotel/controller/transactionController.dart';
import 'package:somudro_bilash_hotel/model/booking_model.dart';
import 'package:somudro_bilash_hotel/model/rooms_model.dart';
import 'package:somudro_bilash_hotel/view/screens/transaction/transacionView_page.dart';

class BookingOverview extends StatelessWidget {
  final Room room;

  BookingOverview({Key? key, required this.room}) : super(key: key);

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
          '${room.roomNo} - ${room.name}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: Get.find<BookingController>().getBookingDetails(room.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Booking> bookings = snapshot.data;
            return ListView.builder(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white60,
                  elevation: 2.0,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Icon(Icons.edit),
                      ),
                      InkWell(
                        onTap: () {
                          Get.find<TransactionController>().getTransactions(
                            bookings[index].bookingId,
                          );
                          Get.to(() => TransactionView());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.00),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                    'Booking ID: ',
                                    style: keyStyle,
                                  ),
                                  Text(
                                    bookings[index].bookingId.toString(),
                                    style: valueStyle,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 4.0,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    'Booking Status: ',
                                    style: keyStyle,
                                  ),
                                  Text(
                                    bookings[index].bookingStatus.toString(),
                                    style: valueStyle,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 4.0,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    'Customer Name: ',
                                    style: keyStyle,
                                  ),
                                  Text(
                                    bookings[index].customerName.toString(),
                                    style: valueStyle,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 4.0,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    'Phone Number: ',
                                    style: keyStyle,
                                  ),
                                  Text(
                                    bookings[index].customerPhone.toString(),
                                    style: valueStyle,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 4.0,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    'From Date: ',
                                    style: keyStyle,
                                  ),
                                  Text(
                                    DateFormat(DateFormat.ABBR_MONTH_DAY)
                                        .add_jm()
                                        .format(
                                          DateTime.parse(
                                            bookings[index].fromDate.toString(),
                                          ),
                                        ),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 4.0,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    'To Date: ',
                                    style: keyStyle,
                                  ),
                                  Text(
                                      DateFormat(DateFormat.ABBR_MONTH_DAY)
                                          .add_jm()
                                          .format(
                                            DateTime.parse(
                                              bookings[index].toDate.toString(),
                                            ),
                                          ),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
