import 'package:flutter/material.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';

class ChoiceRoomScreen extends StatefulWidget {
  ChoiceRoomScreen({super.key});

  @override
  State<ChoiceRoomScreen> createState() => _ChoiceRoomScreenState();
}

class _ChoiceRoomScreenState extends State<ChoiceRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choice Room'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Abu Taher Mollah',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print('Edit');
                                  },
                                  child: Icon(
                                    (Icons.edit),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text(
                              '01770066585',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Total Room = 4',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.background,
                      thickness: 3,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Single Bed',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage('assets/icons/bed.png'),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '2',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            VerticalDivider(
                              thickness: 3,
                              indent: 0,
                              endIndent: 0,
                              color: Theme.of(context).colorScheme.background,
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Double Bed',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage('assets/icons/bed.png'),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '2',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
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
                    Divider(
                      color: Theme.of(context).colorScheme.background,
                      thickness: 3,
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month),
                            SizedBox(width: 10),
                            Text(
                              '11 Wed, Feb 22 to 18 Wed, Feb 22',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choice Room',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
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
                                      : Theme.of(context)
                                          .colorScheme
                                          .background,
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
                                      : Theme.of(context)
                                          .colorScheme
                                          .background,
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
                  ],
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                onPressed: () {
                  print(selectedItems);
                  Navigator.pushNamed(context, Routes.payment);
                },
                buttonText: 'Next',
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> items = ['101', '102', '103', '104', '105'];

  List<String> items1 = ['201', '202', '203', '204', '205'];

  List<String> selectedItems = [];
}
