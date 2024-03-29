import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/routes.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CheckinScreen extends ConsumerStatefulWidget {
  CheckinScreen({super.key});
  @override
  ConsumerState<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends ConsumerState<CheckinScreen> {
  final TextEditingController searchController = TextEditingController();
  final DateRangePickerController dateRangeController =
      DateRangePickerController();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookingProvider).getBookingsList(
            checkinDate: fromDate.subtract(Duration(days: 1)).toUtc(),
            checkoutDate: toDate.toUtc(),
            status: 'booked',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkin'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: SfDateRangePicker(
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is PickerDateRange) {
                    fromDate = args.value.startDate;
                    toDate = args.value.endDate;
                  }
                },
                selectionMode: DateRangePickerSelectionMode.range,
                initialDisplayDate: DateTime.now(),
                controller: dateRangeController,
                confirmText: 'Search',
                cancelText: 'Clear',
                showActionButtons: true,
                enablePastDates: false,
                onSubmit: (args) {
                  ref.read(bookingProvider).getBookingsList(
                        checkinDate: fromDate.toUtc(),
                        checkoutDate: toDate.toUtc(),
                        status: 'booked',
                      );
                },
                onCancel: () {
                  fromDate = DateTime.now();
                  toDate = DateTime.now();
                  dateRangeController.selectedRange = PickerDateRange(
                    fromDate,
                    toDate,
                  );
                  ref.read(bookingProvider).getBookingsList(
                        checkinDate: fromDate.toUtc(),
                        checkoutDate: toDate.toUtc(),
                        status: 'booked',
                      );
                },
              ),
            ),
            SizedBox(height: 20),
            ref.watch(bookingProvider).isLoading
                ? shimmerWidget(context)
                : Flexible(
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
                      child: ref.watch(bookingProvider).bookingList.length == 0
                          ? Center(
                              child: Text(
                                'No checkin found!',
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
                                          'Checkin List',
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
                                          onTap: () => Navigator.pushNamed(
                                            context,
                                            Routes.selectedRoom,
                                            arguments: ref
                                                .watch(bookingProvider)
                                                .bookingList[index]
                                                .id,
                                          ),
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
}
