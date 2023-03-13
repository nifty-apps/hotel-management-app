import 'package:flutter/material.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';

class ConfirmCheckingScreen extends StatelessWidget {
  ConfirmCheckingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Checkin'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 16,
              ),
              height: MediaQuery.of(context).size.height / 6.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 60,
                    ),
                    title: Text(
                      'Abu Taher Mollah',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '0176526685',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Theme.of(context).colorScheme.background,
                    thickness: 3,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              // height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bill Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Table(
                      border: TableBorder.all(width: 1.0, color: Colors.grey),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Color(0xFFA5A9BB)),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Name'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Price'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Qty'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Total'),
                              ),
                            ),
                          ],
                        ),
                        ..._products.map(
                          (product) => TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(product['name']),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      '${product['price'].toStringAsFixed(2)}'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(product['qty'].toString()),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      '${(product['price'] * product['qty']).toStringAsFixed(2)}'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total'),
                      Text('TK. 100.0'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount'),
                      Text('TK. 100.0'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Advance'),
                      Text('TK. 100.0'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'TK. 100.0',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    onTap: () => Navigator.pushNamed(context, Routes.dashboard),
                    title: 'Checkin Successful !',
                    buttonText: 'Back To Home',
                    imagePath: 'assets/icons/successful.png',
                  ),
                );
              },
              buttonText: 'Confrim Checkin',
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _products = [
    {'name': 'Single Room', 'price': 10000, 'qty': 2},
    {'name': 'Double Room', 'price': 7000, 'qty': 1},
  ];
}
