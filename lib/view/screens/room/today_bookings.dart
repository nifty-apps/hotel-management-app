import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/booking.dart';
import 'package:hotel_management/provider/room.dart';
import 'package:hotel_management/view/widgets/bookings_room_card.dart';

class TodayBookingsScreen extends ConsumerWidget {
  const TodayBookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Bookings"),
      ),
      body: Container(
        child: FutureBuilder(
          future: ref.read(roomProvider).todayBookingRooms(),
          builder: ((context, AsyncSnapshot<List<Booking>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Booking>? bookingsData = snapshot.data;
              if (bookingsData == null) {
                return Container(
                  child: Center(
                    child: Text('Something went wrong!'),
                  ),
                );
              }
              return ListView.builder(
                itemCount: bookingsData.length,
                itemBuilder: ((context, index) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {},
                        child: BookingsRoomCard(
                          bookingsInfo: bookingsData[index],
                        ),
                      ),
                    )),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
    );
  }
}
