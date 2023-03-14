import 'package:flutter/material.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class UpdateCustomerRoom extends StatefulWidget {
  UpdateCustomerRoom({super.key});

  @override
  State<UpdateCustomerRoom> createState() => _UpdateCustomerRoomState();
}

class _UpdateCustomerRoomState extends State<UpdateCustomerRoom> {
  final TextEditingController advanceAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Container(
                      height: 70,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Rooms',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      ImageIcon(
                                          AssetImage('assets/icons/tk.png')),
                                      SizedBox(width: 10),
                                      Text(
                                        '5',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
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
                              child: Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        ImageIcon(
                                            AssetImage('assets/icons/tk.png')),
                                        SizedBox(width: 10),
                                        Text(
                                          '2156',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
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
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Choice Room',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ImageIcon(AssetImage('assets/icons/bed.png')),
                      SizedBox(width: 14),
                      Text(
                        'Single Room Number',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Theme.of(context).colorScheme.background,
                    thickness: 3,
                  ),
                  Container(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: ((context, index) {
                        final item = items[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (selectedItems.contains(item)) {
                                selectedItems.remove(item);
                              } else {
                                selectedItems.add(item);
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: selectedItems.contains(item)
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                              border: Border.all(
                                color: selectedItems.contains(item)
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.background,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                items[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: selectedItems.contains(item)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.background,
                    thickness: 3,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      ImageIcon(AssetImage('assets/icons/bed.png')),
                      SizedBox(width: 14),
                      Text(
                        'Double Room Number',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Theme.of(context).colorScheme.background,
                    thickness: 3,
                  ),
                  Container(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items1.length,
                      itemBuilder: ((context, index) {
                        final item = items1[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (selectedItems.contains(item)) {
                                selectedItems.remove(item);
                              } else {
                                selectedItems.add(item);
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: selectedItems.contains(item)
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                              border: Border.all(
                                color: selectedItems.contains(item)
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.background,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                items1[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: selectedItems.contains(item)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.background,
                    thickness: 3,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Container(
                          height: 63,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Container(
                                  height: 70,
                                  width: 220,
                                  child: CustomTextFormField(
                                    controller: advanceAmountController,
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
                        SizedBox(height: 40),
                        CustomButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.confirmCheckin,arguments: true);
                          },
                          buttonText: 'Update',
                          width: double.infinity,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> items = ['101', '102', '103', '104', '105'];

  List<String> items1 = ['201', '202', '203', '204', '205'];

  List<String> selectedItems = [];
}
