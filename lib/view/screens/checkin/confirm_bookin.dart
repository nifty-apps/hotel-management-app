// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/room_booking.dart' as booking;
import 'package:hotel_management/models/room_booking.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/transaction.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';
import 'package:hotel_management/view/screens/dashboard/dashboard.dart';

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
  int _total = 0;
  int get total => _total;
  int _advancAmount = 0;
  int get advancAmount => _advancAmount;
  int payableAmount = 0;
  List<String> roomsId = [];

  @override
  void initState() {
    super.initState();
    getRooms();
    calculateSubTotal();
    getTotalAdvanceAmount();
    calculatePayableAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getAppBarTitle(),
        ),
        automaticallyImplyLeading:
            [PageType.confirm, PageType.checkin].contains(widget.bookingStatus),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildCustomerDetails(context),
              SizedBox(height: 30),
              buildBillDetails(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ref.watch(bookingProvider).isLoading
            ? SizedBox(
                height: 45,
                width: 45,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox(
                height: 45,
                child: CustomButton(
                  onPressed: () => handleConfirmation(),
                  buttonText: getAppBarTitle(),
                  width: double.infinity,
                ),
              ),
      ),
    );
  }

  // Helper Method
  String getAppBarTitle() {
    if (widget.bookingStatus == PageType.checkin) {
      return 'Confirm Checkin';
    } else if (widget.bookingStatus == PageType.checkout) {
      return 'Confirm Checkout';
    } else {
      return 'Confirm Booking';
    }
  }

  Container buildCustomerDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
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
          SizedBox(height: 5),
          Divider(
            color: Theme.of(context).colorScheme.background,
            thickness: 3,
          ),
        ],
      ),
    );
  }

  Container buildBillDetails(BuildContext context) {
    // print(advancAmount);
    print(ref.read(bookingProvider).advanceController.text);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bill Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text("Duration: ${calculateStayDuration()} days",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  )),
            ],
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
                        child: Text('Room'),
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
                              child: Text(room.number.toString()),
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
                              child: Text(room.roomType.rent.toString()),
                            ),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 10),
          buildBillTitle(
              title: 'Sub Total', amount: total * calculateStayDuration()),
          SizedBox(height: 10),
          buildBillTitle(
              title: 'Discount',
              amount: ref.read(bookingProvider).discountController.text.isEmpty
                  ? 0
                  : widget.bookingStatus == PageType.confirm ||
                          widget.checkinNow
                      ? int.parse(
                          ref.read(bookingProvider).discountController.text)
                      : ref.read(bookingProvider).bookingDetails.discount),
          SizedBox(height: 10),
          buildBillTitle(
            title: 'Advance',
            amount: advancAmount != 0
                ? advancAmount
                : int.parse(ref.read(bookingProvider).advanceController.text),
          ),
          SizedBox(height: 10),
          buildBillTitle(title: 'Payable', amount: payableAmount),
        ],
      ),
    );
  }

  Widget buildBillTitle({required String title, required int amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'TK. $amount',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget buildConfirmationButton() {
    return CustomButton(
        onPressed: () {
          // handleConfirm();
        },
        buttonText: 'Confirm');
  }

  // Calculate the sub total
  int calculateSubTotal() {
    final bookingState = ref.read(bookingProvider);
    for (var room in bookingState.allRoom) {
      _total += room.roomType.rent;
    }
    return _total;
  }

  // Get the all selected rooms
  List<String> getRooms() {
    final bookingState = ref.read(bookingProvider);
    for (var room in bookingState.allRoom) {
      roomsId.add(room.id);
    }
    return roomsId;
  }

// Calculate the advance amount
  int getTotalAdvanceAmount() {
    if (widget.bookingStatus == PageType.confirm || widget.checkinNow == true) {
      _advancAmount =
          int.parse(ref.read(bookingProvider).advanceController.text);
    } else {
      for (var i = 0;
          i < ref.read(transactionProvider).transaction.length;
          i++) {
        _advancAmount += ref.read(transactionProvider).transaction[i].amount;
      }
    }

    return _advancAmount;
  }

// Calculate the payable amount
  calculatePayableAmount() {
    final bookingState = ref.read(bookingProvider);
    final int total = _total;
    if (widget.bookingStatus == PageType.confirm || widget.checkinNow == true) {
      int amount = int.parse(bookingState.discountController.text) +
          int.parse(bookingState.advanceController.text);
      print(bookingState.discountController.text);
      print(bookingState.advanceController.text);
      payableAmount = (total * calculateStayDuration()) - amount;
      return payableAmount;
    } else {
      int amount = bookingState.bookingDetails.discount + _advancAmount;
      payableAmount = (total * calculateStayDuration()) - amount;
      return payableAmount;
    }
  }

  // calculate duration
  int calculateStayDuration() {
    return ref
        .read(bookingProvider)
        .checkOut!
        .difference(ref.read(bookingProvider).checkIn ?? DateTime.now())
        .inDays;
  }

  // Handle the booking
  void handleConfirmation() async {
    final bookingState = ref.read(bookingProvider);
    final isConfirmBooking = widget.bookingStatus == PageType.confirm;
    final isCheckin = widget.bookingStatus == PageType.checkin;

    if (isConfirmBooking || widget.checkinNow == true) {
      final name = bookingState.nameController.text;
      final phone = bookingState.phoneController.text;

      final customer = booking.Customer(name: name, phone: phone);
      final checkIn = bookingState.checkIn!.toUtc();
      final checkOut = bookingState.checkOut!.toUtc();
      final discountText = bookingState.discountController.text;
      final advanceText = bookingState.advanceController.text;
      final discount = discountText.isNotEmpty ? int.parse(discountText) : 0;

      final bookingInfo = RoomBooking(
        customer: customer,
        rooms: roomsId,
        checkIn: checkIn,
        checkOut: checkOut,
        total: total * calculateStayDuration(),
        discount: discount,
        status: isConfirmBooking
            ? 'booked'
            : isCheckin
                ? 'checkedIn'
                : 'checkedOut',
        paymentStatus: payableAmount <= 0 ? 'paid' : 'unpaid',
      );

      // calling booking api
      final bookingId = await bookingState.roomBooking(bookingInfo, context);

      // after booking successfull calling transaction api
      if (bookingId != null) {
        final advanceAmount = int.parse(advanceText);
        await ref.read(transactionProvider).addTransaction(
              paymentMethod: 'cash',
              bookingId: bookingId,
              amount: advanceAmount,
            );
      }
    } else if (isCheckin) {
      // calling checkin api
      final bookingDetails = bookingState.bookingDetails;
      await bookingState.updateBookingStatus(
        id: bookingDetails.id,
        status: 'checkedIn',
      );
    } else {
      // calling checkin api
      final bookingDetails = bookingState.bookingDetails;
      await bookingState.updateBookingStatus(
        id: bookingDetails.id,
        status: 'checkedOut',
      );
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDialog(
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardScreen(),
              ),
              (route) => false);
          clearData();
        },
        title: isConfirmBooking
            ? 'Successfully booked!'
            : isCheckin
                ? 'Successfully checked in!'
                : 'Successfully checked out!',
        buttonText: 'Back To Home',
        imagePath: 'assets/icons/successful.png',
      ),
    );
  }

// clear the all data after the booking is done
  void clearData() {
    ref.read(bookingProvider).nameController.clear();
    ref.read(bookingProvider).phoneController.clear();
    ref.read(bookingProvider).advanceController.clear();
    ref.read(bookingProvider).discountController.clear();
    ref.read(bookingProvider).checkIn = null;
    ref.read(bookingProvider).checkOut = null;
    ref.read(bookingProvider).allRoom.clear();
  }
}
