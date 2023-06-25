// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/response_message.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/transaction.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class PaymentScreen extends ConsumerWidget {
  final int advance;
  PaymentScreen({
    required this.advance,
  });
  final TextEditingController advanceAmountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingDetails = ref.watch(bookingProvider).bookingDetails;
    final int totalAmount = bookingDetails.total - bookingDetails.discount;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                          '${DateFormat('dd EEE, MMM yyyy', 'en_US').format(bookingDetails.checkIn.toLocal())} to ${DateFormat('dd EEE, MMM yyyy', 'en_US').format(bookingDetails.checkOut.toLocal())}',
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
                                    'Total ',
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
                                    'Due ',
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
                      SizedBox(height: 40),
                      CustomTextFormField(
                        controller:
                            ref.watch(bookingProvider).advanceController,
                        hintText: 'Enter amount',
                        labelText: 'Advance Amount',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter amount';
                          } else if (int.tryParse(value) == null) {
                            return 'Amount must be a number';
                          } else if (int.parse(value) > totalAmount - advance) {
                            return 'Amount can\'t be greater than due amount';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 100),
                      ref.watch(transactionProvider).isLoading ||
                              ref.watch(bookingProvider).isLoading
                          ? CircularProgressIndicator()
                          : CustomButton(
                              radius: 8,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ResponseMessage responseMessage = await ref
                                      .read(transactionProvider)
                                      .addTransaction(
                                        paymentMethod: "cash",
                                        bookingId: bookingDetails.id,
                                        amount: int.parse(
                                          ref
                                              .read(bookingProvider)
                                              .advanceController
                                              .text
                                              .trim(),
                                        ),
                                      );
                                  showSnackBarMethod(
                                      context,
                                      responseMessage.message,
                                      responseMessage.isSuccess);
                                  if (responseMessage.isSuccess) {
                                    await ref
                                        .read(transactionProvider)
                                        .getTransactionList(
                                            bookingDetails.id, true);
                                    await ref
                                        .read(bookingProvider)
                                        .getBookingDetails(
                                            id: bookingDetails.id);

                                    Navigator.pushReplacementNamed(
                                      context,
                                      Routes.confirmCheckin,
                                      arguments: [PageType.checkin, false],
                                    );
                                  }
                                }
                              },
                              buttonText: 'Payment',
                              width: double.infinity,
                            ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(double.infinity, 42),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade200,
                          ),
                        ),
                        onPressed: () {
                          ref.read(bookingProvider).advanceController.text =
                              '0';
                          Navigator.pushNamed(
                            context,
                            Routes.confirmCheckin,
                            arguments: [PageType.checkin, false],
                          );
                        },
                        child: Text(
                          'SKIP PAYMENT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
