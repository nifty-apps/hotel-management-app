import 'package:flutter/material.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({super.key});

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Revenue'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            bottomLeft: Radius.circular(100),
                          ),
                          color: selectedIndex == 0
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Last Week',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: selectedIndex == 0
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 2,
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.zero,
                        color: selectedIndex == 1
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Last Month',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: selectedIndex == 1
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 2,
                    width: 2,
                  ),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          ),
                          color: selectedIndex == 2
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Last Year',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: selectedIndex == 2
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Amount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Divider(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  thickness: 3,
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '20 jan, 2024',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '1000 TK',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
