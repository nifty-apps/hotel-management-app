import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/transaction.dart';

class BookingDetailsScreen extends ConsumerStatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  ConsumerState<BookingDetailsScreen> createState() =>
      _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends ConsumerState<BookingDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTotalAdvanceAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingDetails = ref.watch(bookingProvider).bookingDetails;
    final dueAmount = getDueAmount(
        subTotal: bookingDetails.total, discount: bookingDetails.discount);
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Center(
        child: ref.watch(bookingProvider).isLoading
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
                              bookingDetails.customer.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              bookingDetails.customer.phone,
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
                                DateFormat('dd EEE, MMM yy', 'en_US')
                                    .format(bookingDetails.checkIn.toLocal()),
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
                                DateFormat('dd EEE, MMM yy', 'en_US')
                                    .format(bookingDetails.checkOut.toLocal()),
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
                                bookingDetails.status,
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
                          Text(
                            'Details',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
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
                                ...bookingDetails.rooms
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
                            value: bookingDetails.total.toString(),
                          ),
                          SizedBox(height: 10),
                          detailsTile(
                            title: 'Discount',
                            value: bookingDetails.discount.toString(),
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

  int advancAmount = 0;
  int dueAmount = 0;

  getTotalAdvanceAmount() {
    print('Print get the total advance amount');
    for (var i = 0;
        i < ref.watch(transactionProvider).transaction.length;
        i++) {
      setState(() {
        advancAmount += ref.watch(transactionProvider).transaction[i].amount;
      });
    }
    return advancAmount;
  }

  getDueAmount({required int subTotal, required int discount}) {
    dueAmount = subTotal - advancAmount - discount;
    return dueAmount;
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
}
