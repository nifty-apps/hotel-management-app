import 'package:flutter/material.dart';

class RevenuePage extends StatefulWidget {
  @override
  _RevenuePageState createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text('Revenue'),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Total Revenue',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  '32000 TAKA',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
