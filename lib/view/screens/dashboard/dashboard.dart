import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/widgets/dashboard_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'The Dream House',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              physics: NeverScrollableScrollPhysics(),
              children: [
                DashboardTile(
                  title: 'Total Rooms',
                  count: Random().nextInt(500),
                  onTap: () {},
                ),
                DashboardTile(
                  title: 'Today Bookings',
                  count: Random().nextInt(500),
                  onTap: () {},
                ),
                DashboardTile(
                  title: 'Occupied Rooms',
                  count: Random().nextInt(500),
                  onTap: () {},
                ),
                DashboardTile(
                  title: 'Available Rooms',
                  count: Random().nextInt(500),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.availableRoom);
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('Recent Booking'),
            SizedBox(height: 16),
            Column(
              children: List.generate(
                20,
                (index) {
                  return ListTile(
                    title: Text('Booking ${index + 1}'),
                    subtitle: Text('Date: ${DateTime.now().toLocal()}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
