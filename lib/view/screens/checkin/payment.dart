import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/booking_details.dart';
import 'package:hotel_management/models/transaction.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/transaction.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class PaymentScreen extends ConsumerWidget {
  PaymentScreen({super.key});
  final TextEditingController discountController = TextEditingController();
  final TextEditingController advanceAmountController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BookingDetails bookingDetails = ref.watch(bookingProvider).bookingDetails;
    final advance =
        getTotalAdvanceAmount(ref.read(transactionProvider).transaction);
    final int totalAmount = bookingDetails.total - bookingDetails.discount;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            height: MediaQuery.of(context).size.height / 3.5,
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
                  title: Text(bookingDetails.customer.name),
                  subtitle: Text(bookingDetails.customer.phone),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(width: 10),
                      Text(
                        '${DateFormat('dd EEE, MMM yy', 'en_US').format(DateTime.parse(bookingDetails.checkIn))} to ${DateFormat('dd EEE, MMM yy', 'en_US').format(DateTime.parse(bookingDetails.checkOut))}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 70,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  'Total Amount',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset('assets/icons/tk.png'),
                                    SizedBox(width: 10),
                                    Text(
                                      "$totalAmount",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(
                          thickness: 1,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  'Advance ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset('assets/icons/tk.png'),
                                    SizedBox(width: 10),
                                    Text(
                                      advance.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(
                          thickness: 1,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  'Due Amount',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset('assets/icons/tk.png'),
                                    SizedBox(width: 10),
                                    Text(
                                      '${totalAmount - advance}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Theme.of(context).colorScheme.background,
                  thickness: 3,
                  indent: 16,
                  endIndent: 16,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Container(
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 70,
                              width: 220,
                              child: CustomTextFormField(
                                controller: discountController,
                                hintText: 'Enter amount',
                                labelText: 'Discount',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Color(0xFFA5A9BB),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Discount Amount',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    CustomTextFormField(
                      controller: advanceAmountController,
                      hintText: 'Enter amount',
                      labelText: 'Advance Amount',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 200),
                    CustomButton(
                      onPressed: () async {
                        if (discountController.text.isNotEmpty) {
                          ref.read(bookingProvider).discountController.text =
                              discountController.text;
                        }
                        if (advanceAmountController.text.isNotEmpty) {
                          ref.read(transactionProvider).addTransaction(
                                "Cash",
                                bookingDetails.id,
                                int.parse(advanceAmountController.text.trim()),
                                context,
                              );
                          ref
                              .read(transactionProvider)
                              .getTransactionList(bookingDetails.id, true);
                        }
                        Navigator.pushNamed(
                          context,
                          Routes.confirmCheckin,
                          arguments: [
                            PageType.checkin,
                          ],
                        );
                      },
                      buttonText: 'Payment',
                      width: double.infinity,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getTotalAdvanceAmount(List<Transaction> transactions) {
    double total = 0;
    for (var i = 0; i < transactions.length; i++) {
      total += transactions[i].amount;
    }
    return total;
  }
}
