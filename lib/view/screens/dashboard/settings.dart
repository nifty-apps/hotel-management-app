import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/settings_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  onTap: () {
                    Navigator.pushNamed(context, Routes.roomTypeList);
                  },
                ),
                SizedBox(width: 20),
                SettingsCard(
                  icon: 'assets/icons/room.png',
                  title: 'Room',
                  onTap: () => Navigator.pushNamed(context, Routes.roomList),
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
              children: [
                SettingsCard(
                  icon: 'assets/icons/customer.png',
                  title: 'Customer',
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.customerList),
                ),
                SizedBox(width: 30),
                SettingsCard(
                  icon: 'assets/icons/transaction.png',
                  title: 'Transaction',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.transaction);
                  },
                ),
                SizedBox(width: 30),
                SettingsCard(
                  icon: 'assets/icons/revenue.png',
                  title: 'Revenue',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.revenue);
                  },
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
                  onTap: () {
                    Navigator.pushNamed(context, Routes.manageEmployee);
                  },
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
                  onPressed: () async {
                    bool isSuccess = await ref.read(authProvider).logout();
                    if (isSuccess) {
                      Navigator.pushNamed(context, Routes.login);
                    }
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
