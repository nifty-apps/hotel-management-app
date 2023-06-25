import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/transaction.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/transaction.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/view/base/date_picker_button.dart';
import 'package:hotel_management/view/base/search_button.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  CheckoutScreen({super.key});
  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final TextEditingController searchController = TextEditingController();
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookingProvider).getBookingsList(
            checkinDate: fromDate!.subtract(Duration(days: 1)).toUtc(),
            checkoutDate: toDate!.toUtc(),
            status: 'checkedIn',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Checkin',
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
                                        fromDate = date;
                                      });
                                    }
                                  },
                                  child: DatePickerButton(date: fromDate),
                                ),
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
                                  'Checkout',
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
                                        toDate = date;
                                      });
                                    }
                                  },
                                  child: DatePickerButton(date: toDate),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SearchButton(
                    onPressed: () {
                      ref.read(bookingProvider).getBookingsList(
                            checkinDate: fromDate!.subtract(Duration(days: 1)),
                            checkoutDate: toDate!.toUtc(),
                            status: 'checkedIn',
                          );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ref.watch(bookingProvider).isLoading
                ? shimmerWidget(context)
                : Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: ref.watch(bookingProvider).bookingList.length == 0
                          ? Center(
                              child: Text(
                                'No checkout found!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ref.watch(bookingProvider).bookingList.length ==
                                        0
                                    ? SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Text(
                                          'Checkout List',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                Flexible(
                                  child: ListView.builder(
                                    itemCount: ref
                                        .watch(bookingProvider)
                                        .bookingList
                                        .length,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        Divider(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          thickness: 3,
                                        ),
                                        ListTile(
                                          onTap: () async {
                                            final bookingList = ref
                                                .watch(bookingProvider)
                                                .bookingList;
                                            final booking = bookingList[index];

                                            ref
                                                .read(bookingProvider)
                                                .getBookingDetails(
                                                    id: booking.id);
                                            ref
                                                .read(transactionProvider)
                                                .getTransactionList(
                                                    booking.id, true);

                                            final int data =
                                                getTotalAdvanceAmount(ref
                                                    .read(transactionProvider)
                                                    .transaction);

                                            final bool isPaid =
                                                booking.paymentStatus == 'paid';
                                            if (isPaid) {
                                              ref
                                                  .read(bookingProvider)
                                                  .setBookingDetails();
                                            } else {
                                              print('unpaid');
                                            }
                                            Navigator.pushNamed(
                                              context,
                                              isPaid
                                                  ? Routes.confirmCheckin
                                                  : Routes.checkoutDue,
                                              arguments: isPaid
                                                  ? [PageType.checkout, false]
                                                  : data.toInt(),
                                            );
                                          },
                                          leading: Icon(Icons.person),
                                          trailing: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          title: Text(ref
                                              .read(bookingProvider)
                                              .bookingList[index]
                                              .customer
                                              .name),
                                          subtitle: Text(ref
                                              .read(bookingProvider)
                                              .bookingList[index]
                                              .customer
                                              .phone),
                                        ),
                                      ],
                                    ),
                                  ),
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

  Widget shimmerWidget(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.background,
              highlightColor: Theme.of(context).highlightColor,
              child: Container(
                margin: EdgeInsets.all(20),
                height: 10,
                width: 100,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Theme.of(context).colorScheme.background,
                      highlightColor: Theme.of(context).highlightColor,
                      child: Divider(
                        color: Theme.of(context).colorScheme.background,
                        thickness: 3,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Theme.of(context).colorScheme.background,
                      highlightColor: Theme.of(context).highlightColor,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Container(
                          height: 10,
                          width: 200,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        subtitle: Container(
                          height: 10,
                          width: 100,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  int getTotalAdvanceAmount(List<Transaction> transactions) {
    int total = 0;
    for (var i = 0; i < transactions.length; i++) {
      total += transactions[i].amount;
    }
    return total;
  }
}
