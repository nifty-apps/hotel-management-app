import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/response_message.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/transaction.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';
import 'package:hotel_management/view/base/search_text_form_field.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class PartialPaymentScreen extends ConsumerStatefulWidget {
  PartialPaymentScreen({super.key});

  @override
  ConsumerState<PartialPaymentScreen> createState() =>
      _PartialPaymentScreenState();
}

class _PartialPaymentScreenState extends ConsumerState<PartialPaymentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String bookingId = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookingProvider).getListOfCustomerBookings('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Partial Payment'),
          automaticallyImplyLeading: false,
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Partial Payment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.background,
                    thickness: 3,
                    endIndent: 5,
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: nameController,
                    readOnly: true,
                    hintText: 'Name',
                    labelText: 'Name',
                    keyboardType: TextInputType.text,
                    isSuffixIcon: true,
                    suffixButtonAction: () {
                      showDialog(
                        context: context,
                        builder: (context) => bookingsDialog(),
                      );
                    },
                    validator: (value) {
                      if (nameController.text.isEmpty) {
                        return 'Fill the name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: phoneController,
                    readOnly: true,
                    hintText: 'Phone',
                    labelText: 'Phone',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (phoneController.text.isEmpty) {
                        return 'Fill the phone';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: amountController,
                    hintText: 'Amount',
                    labelText: 'Amount',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (amountController.text.isEmpty) {
                        return 'Please enter amount';
                      } else if (int.tryParse(value!) == null) {
                        return 'Amount must be a number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 36),
                  ref.watch(transactionProvider).isLoading
                      ? CircularProgressIndicator()
                      : CustomButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ResponseMessage responseMessage = await ref
                                  .read(transactionProvider)
                                  .addTransaction(
                                    paymentMethod: 'cash',
                                    bookingId: bookingId,
                                    amount: int.parse(amountController.text),
                                  );
                              if (responseMessage.isSuccess == true) {
                                bookingId = '';
                                nameController.clear();
                                phoneController.clear();
                                amountController.clear();
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomDialog(
                                    title: responseMessage.message,
                                    buttonText: 'Back To Home',
                                    onTap: () => Navigator.pushNamed(
                                        context, Routes.dashboard),
                                    imagePath: 'assets/icons/successful.png',
                                  ),
                                );
                                setState(() {});
                              } else {
                                showSnackBarMethod(
                                    context,
                                    responseMessage.message,
                                    responseMessage.isSuccess);
                              }
                            }
                          },
                          buttonText: 'Payment',
                          width: double.infinity,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bookingsDialog() {
    TextEditingController searchController = TextEditingController();
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Container(
            height: MediaQuery.of(context).size.height / 2,
            child: ref.watch(bookingProvider).isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SearchTextFormField(
                        hintText: 'Search with phone number',
                        controller: searchController,
                        onTap: () async {
                          await ref
                              .read(bookingProvider)
                              .getListOfCustomerBookings(searchController.text);
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: ref
                                .watch(bookingProvider)
                                .listOfCustomer
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
                                    onTap: () {
                                      nameController.text = ref
                                          .read(bookingProvider)
                                          .listOfCustomer[index]
                                          .customer
                                          .name;
                                      phoneController.text = ref
                                          .read(bookingProvider)
                                          .listOfCustomer[index]
                                          .customer
                                          .phone;
                                      bookingId = ref
                                          .read(bookingProvider)
                                          .listOfCustomer[index]
                                          .bookingId;
                                      Navigator.pop(context);
                                    },
                                    leading: Icon(
                                      Icons.person,
                                      size: 40,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    title: Text(
                                      ref
                                          .read(bookingProvider)
                                          .listOfCustomer[index]
                                          .customer
                                          .name,
                                    ),
                                    subtitle: Text(
                                      ref
                                          .read(bookingProvider)
                                          .listOfCustomer[index]
                                          .customer
                                          .phone,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
