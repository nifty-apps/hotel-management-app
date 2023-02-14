import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/booking.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class BookingsRoomCard extends ConsumerWidget {
  final Booking bookingsInfo;
  BookingsRoomCard({Key? key, required this.bookingsInfo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String roomType = bookingsInfo.room['roomType'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Text(
                bookingsInfo.room['number'],
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height / 6,
              margin: EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomType.toTitleCase(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    bookingsInfo.room['floor'],
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Text(
                    bookingsInfo.customer.name,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bookingsInfo.customer.phone,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          UrlLauncher.launchUrl(
                            Uri.parse(
                                "tel://${bookingsInfo.customer.phone.toString()}"),
                          );
                        },
                        child: Text(
                          'Call now',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMMMd().format(bookingsInfo.checkIn),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        DateFormat.yMMMd().format(bookingsInfo.checkOut),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).errorColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(
                    'BDT ${bookingsInfo.room['rent']}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
