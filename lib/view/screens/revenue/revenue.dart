import 'package:flutter/material.dart';

class RevenuePage extends StatefulWidget {
  @override
  _RevenuePageState createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  final keystyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  final valuestyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Revenue'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 6,
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Revenue Reports',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Text(
                              'Somudro Bilash',
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.red,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Wrap(children: [
                          Text(
                            "Today: ",
                            style: keystyle,
                          ),
                          Text(
                            "878 BDT",
                            style: valuestyle,
                          )
                        ]),
                        SizedBox(
                          height: 5,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Yesterday: ",
                              style: keystyle,
                            ),
                            Text(
                              "242 BDT",
                              style: valuestyle,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Wrap(children: [
                          Text(
                            "Last week: ",
                            style: keystyle,
                          ),
                          Text(
                            "665 BDT",
                            style: valuestyle,
                          )
                        ]),
                        SizedBox(
                          height: 5,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Last month: ",
                              style: keystyle,
                            ),
                            Text(
                              "4545 BDT",
                              style: valuestyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Last year: ",
                              style: keystyle,
                            ),
                            Text(
                              "1525} BDT",
                              style: valuestyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
