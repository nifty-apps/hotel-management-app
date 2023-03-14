import 'package:flutter/material.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class PartialPaymentScreen extends StatelessWidget {
  PartialPaymentScreen({super.key});
  final TextEditingController bookingIdController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Partial Payment'),
        ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    controller: bookingIdController,
                    hintText: 'Booking ID',
                    labelText: 'Booking ID',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (bookingIdController.text.isEmpty) {
                        return 'Please enter booking ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: bookingIdController,
                    hintText: 'Name',
                    labelText: 'Name',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (bookingIdController.text.isEmpty) {
                        return 'Please enter booking ID';
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
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 36),
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                            title: 'Payment Successful !',
                            buttonText: 'Back To Home',
                            onTap: () =>
                                Navigator.pushNamed(context, Routes.dashboard),
                            imagePath: 'assets/icons/successful.png',
                          ),
                        );
                      } else {
                        print('not validated');
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
}
