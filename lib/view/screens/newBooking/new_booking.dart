import 'package:flutter/material.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';
import 'package:hotel_management/view/base/date_picker_button.dart';
import 'package:hotel_management/view/base/search_button.dart';

class NewBookingScreen extends StatefulWidget {
  NewBookingScreen({super.key});

  @override
  State<NewBookingScreen> createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Booking'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'From Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              InkWell(
                                  onTap: () async {
                                    final date = await selectDate(context);
                                    setState(() {
                                      fromDate = date;
                                    });
                                  },
                                  child: DatePickerButton(date: fromDate)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'To Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              InkWell(
                                onTap: () async {
                                  final date = await selectDate(context);
                                  setState(() {
                                    toDate = date;
                                  });
                                },
                                child: DatePickerButton(date: toDate),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SearchButton(
                    onPressed: () {
                      print('something went wrong');
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          title: 'Room not available !',
                          buttonText: 'Search Again',
                          imagePath: 'assets/icons/warning.png',
                          onTap: () => Navigator.pop(context),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Rooms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 250,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = items[index]['roomType'];
                        return GestureDetector(
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            margin: EdgeInsets.all(5),
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                              color: selectedItems.contains(item)
                                  ? Theme.of(context).colorScheme.primary
                                  : Color(0xFF2DCC70),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index]['roomType'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    ImageIcon(
                                      AssetImage('assets/icons/bed.png'),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      items[index]['number'].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.choiceRooms,
                        arguments: true,
                      );
                    },
                    buttonText: 'Select Category',
                    width: double.infinity,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showBottomSheet(List<String> selectedList) {
    int count = 0;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Rooms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 300,
                    child: ListView.builder(
                        itemCount: selectedList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        selectedList[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Tk 500',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 40,
                                    width: 180,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            onTap: () {
                                              setState(() {
                                                if (count != 0) {
                                                  count--;
                                                }
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Color(0xFFE0EBF5),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            child: Center(
                                              child: Text(count.toString()),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            onTap: () {
                                              setState(() {
                                                count++;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Color(0xFFE0EBF5),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                color: Theme.of(context).colorScheme.background,
                                thickness: 3,
                              ),
                            ],
                          );
                        }),
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.customerBookingInfo);
                    },
                    buttonText: 'Apply',
                    width: double.infinity,
                  )
                ],
              ),
            );
          });
        });
  }
}

final List<Map<String, dynamic>> items = [
  {'roomType': 'Single Bed', 'number': 5, 'pricePerRoom': 50},
  {'roomType': 'Double Bed', 'number': 10, 'pricePerRoom': 80},
  {'roomType': 'Suite Bed', 'number': 2, 'pricePerRoom': 200},
  {'roomType': 'Penthouse Bed', 'number': 1, 'pricePerRoom': 500},
  {'roomType': 'Single Bed', 'number': 5, 'pricePerRoom': 50},
  {'roomType': 'Double Bed', 'number': 10, 'pricePerRoom': 80},
  {'roomType': 'Suite Bed', 'number': 2, 'pricePerRoom': 200},
  {'roomType': 'Penthouse Bed', 'number': 1, 'pricePerRoom': 500},
];
List<String> selectedItems = [];
