import 'package:flutter/material.dart';
import 'package:hotel_management/view/base/settings_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: Icon(Icons.settings),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Room',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SettingsCard(
                  icon: 'assets/icons/room_type.png',
                  title: 'Room Type',
                  onTap: () {},
                ),
                SizedBox(width: 20),
                SettingsCard(
                  icon: 'assets/icons/room.png',
                  title: 'Room',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'History',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SettingsCard(
                  icon: 'assets/icons/customer.png',
                  title: 'Customer',
                  onTap: () {},
                ),
                SizedBox(width: 20),
                SettingsCard(
                  icon: 'assets/icons/checkin.png',
                  title: 'Check In',
                  onTap: () {},
                ),
                SizedBox(width: 20),
                SettingsCard(
                  icon: 'assets/icons/checkout.png',
                  title: 'Check Out',
                  onTap: () {},
                ),
                SizedBox(width: 20),
                SettingsCard(
                  icon: 'assets/icons/revenue.png',
                  title: 'Revenue',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SettingsCard(
                  icon: 'assets/icons/profile.png',
                  title: 'Profile',
                  onTap: () {},
                ),
                SizedBox(width: 20),
                SettingsCard(
                  icon: 'assets/icons/hotel.png',
                  title: 'Hotel',
                  onTap: () {},
                ),
                SizedBox(width: 20),
                SettingsCard(
                  icon: 'assets/icons/employee.png',
                  title: 'Employee',
                  onTap: () {},
                ),
                SizedBox(width: 20),
                SettingsCard(
                  icon: 'assets/icons/support.png',
                  title: 'Support',
                  onTap: () {},

                  
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.logout),
                    label: Text('Logout')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}