// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/available_room.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/date_picker_button.dart';
import 'package:hotel_management/view/base/search_button.dart';
import 'package:intl/intl.dart';

class UpdateBooking extends ConsumerStatefulWidget {
  final String bookingId;
  final DateTime checkoutDate;
  final List<String> roomIds;
  const UpdateBooking({
    Key? key,
    required this.bookingId,
    required this.checkoutDate,
    required this.roomIds,
  }) : super(key: key);

  @override
  ConsumerState<UpdateBooking> createState() => _UpdateBookingState();
}

class _UpdateBookingState extends ConsumerState<UpdateBooking> {
  DateTime extentionCheckoutDate = DateTime.now();
  List<Room> rooms = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Booking'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Checkout Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(DateFormat('dd EEE, MMM yyyy', 'en_US')
                                  .format(widget.checkoutDate))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Extends Checkout Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              InkWell(
                                onTap: () async {
                                  final date = await selectDate(context);
                                  if (date != null) {
                                    setState(() {
                                      extentionCheckoutDate = date;
                                    });
                                  }
                                },
                                child: DatePickerButton(
                                  date: extentionCheckoutDate,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SearchButton(
                    onPressed: () async {
                      // TODO
                      if (widget.checkoutDate.isAfter(extentionCheckoutDate)) {
                        showSnackBarMethod(context,
                            'Select the valid extends checkout date!', false);
                      } else if (widget.checkoutDate
                          .isBefore(extentionCheckoutDate)) {
                        final listOfRoom = await ref
                            .read(bookingProvider)
                            .checkRoomsAvailability(
                              checkoutDate: widget.checkoutDate,
                              extendsCheckoutDate: extentionCheckoutDate,
                              roomIds: widget.roomIds,
                            );
                        setState(() {
                          rooms = listOfRoom;
                        });
                      } else {
                        showSnackBarMethod(context,
                            'Select the valid extends checkout date!', false);
                      }
                    },
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: ref.watch(bookingProvider).isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : rooms.length == 0
                      ? Center(
                          child: Text(
                            'No Rooms Available',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'All Room Available. Click on the update button and update the checkout date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 50),
                              CustomButton(
                                onPressed: () async {
                                  print(widget.bookingId);
                                  if (widget.checkoutDate
                                      .isAfter(extentionCheckoutDate)) {
                                    showSnackBarMethod(
                                        context,
                                        'Select the valid extends checkout date!',
                                        false);
                                  } else if (widget.checkoutDate
                                      .isBefore(extentionCheckoutDate)) {
                                    bool isSuccess = await ref
                                        .read(bookingProvider)
                                        .updateCheckoutDate(
                                          id: widget.bookingId,
                                          date: extentionCheckoutDate,
                                        );
                                    if (isSuccess) {
                                      await ref
                                          .read(bookingProvider)
                                          .getBookingDetails(
                                              id: widget.bookingId);
                                      Navigator.pop(context);
                                      showSnackBarMethod(context,
                                          'Checkout Date Updated', true);
                                    } else {
                                      Navigator.pop(context);
                                      showSnackBarMethod(context,
                                          'Checkout Date Not Updated', false);
                                    }
                                  } else {
                                    showSnackBarMethod(
                                        context,
                                        'Select the valid extends checkout date!',
                                        false);
                                  }
                                },
                                buttonText: 'Update',
                              ),
                            ],
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
