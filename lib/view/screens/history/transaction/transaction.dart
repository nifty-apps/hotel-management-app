import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/transaction.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transactionProvider).getTransactionHistory(
            fromDate: fromDate!.subtract(Duration(days: 1)).toUtc(),
            toDate: toDate!.toUtc(),
          );
    });
  }

  final DateRangePickerController dateRangeController =
      DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: Column(
        children: [
          Container(
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
              enablePastDates: true,
              onSubmit: (args) {
                ref.read(transactionProvider).getTransactionHistory(
                      fromDate: fromDate!.toUtc(),
                      toDate: toDate!.toUtc(),
                    );
                print(fromDate);
                print(toDate);
              },
              onCancel: () {
                fromDate = DateTime.now();
                toDate = DateTime.now();
                ref.read(transactionProvider).getTransactionHistory(
                      fromDate: fromDate!.toUtc(),
                      toDate: toDate!.toUtc(),
                    );
                dateRangeController.selectedRange =
                    PickerDateRange(fromDate!, toDate!);
              },
            ),
          ),
          ref.watch(transactionProvider).isLoading
              ? shimmerWidget()
              : Flexible(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child:
                        ref.watch(transactionProvider).transaction.length == 0
                            ? Center(
                                child: Text(
                                  'No transction found!',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          'Amount',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: ListView.builder(
                                        itemCount: ref
                                            .watch(transactionProvider)
                                            .transaction
                                            .length,
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                              child: Divider(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                                thickness: 3,
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(ref
                                                  .read(transactionProvider)
                                                  .transaction[index]
                                                  .booking
                                                  .customer
                                                  .name),
                                              subtitle: Text(ref
                                                  .read(transactionProvider)
                                                  .transaction[index]
                                                  .booking
                                                  .customer
                                                  .phone),
                                              trailing: Text(
                                                '${ref.read(transactionProvider).transaction[index].amount}TK',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                  ),
                )
        ],
      ),
    );
  }

  Widget shimmerWidget() {
    return Flexible(
      flex: 2,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.background,
                highlightColor: Theme.of(context).highlightColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: 45,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    Container(
                      height: 10,
                      width: 45,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          color: Theme.of(context).colorScheme.background,
                          thickness: 3,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).colorScheme.background,
                        highlightColor: Theme.of(context).highlightColor,
                        child: ListTile(
                          title: Container(
                            height: 10,
                            width: 50,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 60,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          trailing: Container(
                            height: 10,
                            width: 45,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
