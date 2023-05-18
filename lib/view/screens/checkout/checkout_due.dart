// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/transaction.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class CheckoutDueScreen extends ConsumerWidget {
  final int advanceAmount;
  CheckoutDueScreen({
    required this.advanceAmount,
  });

  final TextEditingController dueAmountController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int dueAmount = ref.read(bookingProvider).bookingDetails.total -
        ref.read(bookingProvider).bookingDetails.discount -
        advanceAmount;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
        ),
        body: ref.watch(bookingProvider).isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.person,
                                size: 50,
                              ),
                              title: Text(ref
                                  .read(bookingProvider)
                                  .bookingDetails
                                  .customer
                                  .name),
                              subtitle: Text(ref
                                  .read(bookingProvider)
                                  .bookingDetails
                                  .customer
                                  .phone),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  SizedBox(width: 10),
                                  Text(
                                    'Checkout ${DateFormat('dd EEE, MMM yy', 'en_US').format(ref.read(bookingProvider).bookingDetails.checkOut.toLocal())}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                height: 60,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Total',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/tk.png',
                                                  width: 25,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  (ref
                                                              .read(
                                                                  bookingProvider)
                                                              .bookingDetails
                                                              .total -
                                                          ref
                                                              .read(
                                                                  bookingProvider)
                                                              .bookingDetails
                                                              .discount)
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
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
                                                Image.asset(
                                                  'assets/icons/tk.png',
                                                  width: 25,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  advanceAmount.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Due',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/tk.png',
                                                  width: 25,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  dueAmount.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
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
                            SizedBox(height: 5),
                            Divider(
                              color: Theme.of(context).colorScheme.background,
                              thickness: 3,
                              indent: 16,
                              endIndent: 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      CustomTextFormField(
                        controller: dueAmountController,
                        hintText: 'Due Amount',
                        labelText: 'Due Amount',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter due amount';
                          } else if (dueAmount != int.parse(value)) {
                            return 'Invalid due amount!';
                          }
                          return null;
                        },
                      ),
                      Spacer(),
                      CustomButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Future.microtask(() async {
                              await ref
                                  .read(transactionProvider)
                                  .addTransaction(context,
                                      paymentMethod: 'cash',
                                      bookingId: ref
                                          .read(bookingProvider)
                                          .bookingDetails
                                          .id,
                                      amount:
                                          int.parse(dueAmountController.text));
                              await ref
                                  .read(transactionProvider)
                                  .getTransactionList(
                                    ref.read(bookingProvider).bookingDetails.id,
                                    true,
                                  );
                              await ref
                                  .read(bookingProvider)
                                  .updatePaymentStatus(
                                      id: ref
                                          .read(bookingProvider)
                                          .bookingDetails
                                          .id,
                                      status: 'unpaid');
                              Navigator.pushNamed(
                                context,
                                Routes.confirmCheckin,
                                arguments: [PageType.checkout, false],
                              );
                            });
                          } else {
                            print('Invalid');
                          }
                        },
                        buttonText: 'Submit',
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
