import 'package:flutter/material.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class CheckoutDueScreen extends StatelessWidget {
  CheckoutDueScreen({super.key});

  final TextEditingController dueAmountController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
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
                        title: Text('Abu Taher Mollah'),
                        subtitle: Text('01738536102'),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month),
                            SizedBox(width: 10),
                            Text(
                              'Checkin 18 Wed, Feb 22',
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
                                        'Total Amount',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          ImageIcon(AssetImage(
                                              'assets/icons/tk.png')),
                                          SizedBox(width: 10),
                                          Text(
                                            '2156',
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
                                          ImageIcon(AssetImage(
                                              'assets/icons/tk.png')),
                                          SizedBox(width: 10),
                                          Text(
                                            '2156',
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
                                          ImageIcon(AssetImage(
                                              'assets/icons/tk.png')),
                                          SizedBox(width: 10),
                                          Text(
                                            '2156',
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
                SizedBox(height: 30),
                CustomTextFormField(
                  controller: dueAmountController,
                  hintText: 'Due Amount',
                  labelText: 'Due Amount',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter due amount';
                    }
                    return null;
                  },
                ),
                Spacer(),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, Routes.confirmCheckin,arguments: false);
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
