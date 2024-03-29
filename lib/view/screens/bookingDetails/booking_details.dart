import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/transaction.dart';

class BookingDetailsScreen extends ConsumerStatefulWidget {
  final String bookingID;
  const BookingDetailsScreen({
    Key? key,
    required this.bookingID,
  }) : super(key: key);

  @override
  ConsumerState<BookingDetailsScreen> createState() =>
      _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends ConsumerState<BookingDetailsScreen> {
  int _advancAmount = 0;
  int get advancAmount => _advancAmount;
  int _dueAmount = 0;
  int get dueAmount => _dueAmount;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(bookingProvider).getBookingDetails(id: widget.bookingID);
      await ref
          .read(transactionProvider)
          .getTransactionList(widget.bookingID, true);
      getTotalAdvanceAmount();
      getDueAmount(
        subTotal: ref.read(bookingProvider).bookingDetails.total,
        discount: ref.read(bookingProvider).bookingDetails.discount,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(bookingProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Center(
        child: provider.isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Container(
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
                              provider.bookingDetails.customer.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              provider.bookingDetails.customer.phone,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CheckIn Date',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                DateFormat('dd EEE, MMM yyyy', 'en_US').format(
                                    provider.bookingDetails.checkIn.toLocal()),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Checkout Date',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                DateFormat('dd EEE, MMM yyyy', 'en_US').format(
                                    provider.bookingDetails.checkOut.toLocal()),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Booking status',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                provider.bookingDetails.status,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Duration ${calculateStayDuration()} days",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Table(
                              border: TableBorder.all(
                                  width: 1.0, color: Colors.grey),
                              children: [
                                TableRow(
                                  decoration:
                                      BoxDecoration(color: Color(0xFFA5A9BB)),
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
                                ...provider.bookingDetails.rooms
                                    .map(
                                      (room) => TableRow(
                                        children: [
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                room.number,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                room.roomType.type,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                room.roomType.rent.toString(),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          detailsTile(
                            title: 'Sub Total',
                            value: provider.bookingDetails.total.toString(),
                          ),
                          SizedBox(height: 10),
                          detailsTile(
                            title: 'Discount',
                            value: provider.bookingDetails.discount.toString(),
                          ),
                          SizedBox(height: 10),
                          detailsTile(
                            title: 'Advance',
                            value: advancAmount.toString(),
                          ),
                          SizedBox(height: 10),
                          detailsTile(
                            title: 'Due',
                            value:
                                dueAmount == 0 ? 'Paid' : dueAmount.toString(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget detailsTile({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w700,
          ),
        ),
        title == 'Due' && value == '0'
            ? Text(value)
            : Text(
                'Tk. $value',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ],
    );
  }

  int getTotalAdvanceAmount() {
    for (var i = 0;
        i < ref.watch(transactionProvider).transaction.length;
        i++) {
      setState(() {
        _advancAmount += ref.watch(transactionProvider).transaction[i].amount;
      });
    }
    return _advancAmount;
  }

  int getDueAmount({required int subTotal, required int discount}) {
    _dueAmount = subTotal - advancAmount - discount;
    return _dueAmount;
  }

  int calculateStayDuration() {
    final checkIn = ref.read(bookingProvider).bookingDetails.checkIn.toLocal();
    final checkOut =
        ref.read(bookingProvider).bookingDetails.checkOut.toLocal();
    final difference = checkOut.difference(checkIn).inDays;
    return difference;
  }
}
