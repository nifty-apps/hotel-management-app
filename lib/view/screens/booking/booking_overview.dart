import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/booking_controller.dart';
import 'package:somudro_bilash_hotel/controller/transactionController.dart';
import 'package:somudro_bilash_hotel/model/booking_model.dart';
import 'package:somudro_bilash_hotel/model/rooms_model.dart';
import 'package:somudro_bilash_hotel/view/screens/transaction/transacionView_page.dart';

class BookingOverview extends StatelessWidget {
  final Room room;

  const BookingOverview({Key? key,  required this.room}) : super(key: key);

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
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3.0,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(Icons.edit),
                      ),
                      InkWell(
                        onTap: () {
                          Get.find<TransactionController>().getTransactions(
                            bookings[index].bookingId,
                          );
                          Get.to(() => TransactionView());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Booking ID: ${bookings[index].bookingId.toString()}',
                                ),
                              ],
                            ),
                            Text(bookings[index].bookingStatus),
                            Text(bookings[index].customerName),
                            Text(bookings[index].customerPhone),
                            Text(bookings[index].fromDate),
                            Text(bookings[index].toDate),
                          ],
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
