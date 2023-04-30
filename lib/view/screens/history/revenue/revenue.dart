import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/transaction.dart';
import 'package:hotel_management/util/app_constants.dart';

class RevenueScreen extends ConsumerStatefulWidget {
  const RevenueScreen({super.key});

  @override
  ConsumerState<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends ConsumerState<RevenueScreen> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transactionProvider).getRevenue(timeRange: 'week');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Revenue'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(100),
                      ),
                      onTap: () {
                        ref
                            .read(transactionProvider)
                            .getRevenue(timeRange: 'week');
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'This Week',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: selectedIndex == 0
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        ref
                            .read(transactionProvider)
                            .getRevenue(timeRange: 'month');
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Container(
                        color: selectedIndex == 1
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        child: Center(
                          child: Text(
                            'This Month',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: selectedIndex == 1
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(100),
                      ),
                      onTap: () {
                        ref
                            .read(transactionProvider)
                            .getRevenue(timeRange: 'year');
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex == 2
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'This Year',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: selectedIndex == 2
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: ref.watch(transactionProvider).isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ref
                                .watch(transactionProvider)
                                .hotelRevenue!
                                .transactions
                                .length ==
                            0
                        ? Center(
                            child: Text(
                              'No transaction found!',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          )
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: ref
                                      .watch(transactionProvider)
                                      .hotelRevenue!
                                      .transactions
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Divider(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          thickness: 3,
                                        ),
                                        ListTile(
                                          title: Text(ref
                                              .read(transactionProvider)
                                              .hotelRevenue!
                                              .transactions[index]
                                              .id,style: TextStyle(),),
                                          subtitle: Text(ref
                                              .read(transactionProvider)
                                              .hotelRevenue!
                                              .transactions[index]
                                              .paymentMethod
                                              .toCapitalized()),
                                          trailing: Text(ref
                                                  .read(transactionProvider)
                                                  .hotelRevenue!
                                                  .transactions[index]
                                                  .amount
                                                  .toString() +
                                              ' TK'),
                                        )
                                      ],
                                    );
                                  },
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
}
