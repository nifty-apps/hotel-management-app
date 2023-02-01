import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management/models/transaction_response.dart';
import 'package:intl/intl.dart';

class TransactionView extends StatelessWidget {
  TransactionView({
    Key? key,
    required this.bookingId,
  }) : super(key: key);

  final int bookingId;

  final keystyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );
  final valuestyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder(
        // future: Get.find<BookingController>().getTransactions(bookingId),
        builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Transaction> transactions = snapshot.data ?? [];
            if (transactions.isEmpty) {
              return Center(
                child: Text(
                  'No transactions found!',
                  style: keystyle,
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              itemCount: transactions.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      width: 420,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${transactions[index].roomName}',
                                style: valuestyle,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    'Room No:',
                                    style: keystyle,
                                  ),
                                  Text(
                                    '${transactions[index].roomNumber}',
                                    style: valuestyle,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(children: [
                                Text(
                                  'Total Fare:',
                                  style: keystyle,
                                ),
                                Text(
                                  '${transactions[index].totalFare} BDT',
                                  style: valuestyle,
                                )
                              ]),
                              Wrap(children: [
                                Text(
                                  'Booking ID:',
                                  style: keystyle,
                                ),
                                Text(
                                  '${transactions[index].bookingId}',
                                  style: valuestyle,
                                )
                              ])
                            ],
                          ),
                        ],
                      ),
                    )
                  ]);
                }
                index--;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6.00),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Container(
                            width: 420,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Wrap(
                                      children: [
                                        Text(
                                          "Admin Name: ",
                                          style: keystyle,
                                        ),
                                        Text(
                                          transactions[index]
                                              .adminName
                                              .toString(),
                                          style: valuestyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      "Paid Amount: ",
                                      style: keystyle,
                                    ),
                                    Text(
                                      transactions[index].amount.toString() +
                                          ' BDT',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: transactions[index].amount ==
                                                  transactions[index].totalFare
                                              ? Colors.green
                                              : Colors.red),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  DateFormat(DateFormat
                                          .YEAR_ABBR_MONTH_WEEKDAY_DAY)
                                      .add_jms()
                                      .format(
                                        DateTime.parse(
                                          transactions[index]
                                              .collectionDate
                                              .toString(),
                                        ),
                                      ),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: SpinKitThreeBounce(
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
