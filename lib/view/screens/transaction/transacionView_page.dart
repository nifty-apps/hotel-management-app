import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:somudro_bilash_hotel/controller/transactionController.dart';
import 'package:somudro_bilash_hotel/view/screens/dashboard/dashboard_screen.dart';

class TransactionView extends StatelessWidget {
  TransactionView({Key? key}) : super(key: key);
  final keystyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black54);
  final valuestyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => DashboardScreen());
              ;
            },
            icon: Icon(Icons.arrow_back)),
        // centerTitle: true,
        title: Text('Transactions'),
      ),
      body: GetBuilder<TransactionController>(
        builder: (controller) => controller.isLoading
            ? Center(
                child: SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                itemCount: controller.allTransaction.length + 1,
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
                                  '${controller.allTransaction[index].roomName}',
                                  style: valuestyle,
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      'Room ID:',
                                      style: keystyle,
                                    ),
                                    Text(
                                      '${controller.allTransaction[index].roomNumber}',
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
                                    // controller.allTransaction.roomName.toString(),
                                    'Total Fare:',
                                    style: keystyle,
                                  ),
                                  Text(
                                    '${controller.allTransaction[index].totalFare} BDT',
                                    style: valuestyle,
                                  )
                                ]),
                                Wrap(children: [
                                  Text(
                                    'Booking ID:',
                                    style: keystyle,
                                  ),
                                  Text(
                                    '${controller.allTransaction[index].bookingId}',
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
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                                            controller
                                                .allTransaction[index].adminName
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
                                        controller.allTransaction[index].amount
                                                .toString() +
                                            ' BDT',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: controller
                                                        .allTransaction[index]
                                                        .amount ==
                                                    controller
                                                        .allTransaction[index]
                                                        .totalFare
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
                                            controller.allTransaction[index]
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
              ),
      ),
    );
  }
}
