import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/view/screens/dashboard/checkin_out.dart';
import 'package:hotel_management/view/screens/dashboard/home.dart';
import 'package:hotel_management/view/screens/dashboard/partial_payment.dart';
import 'package:hotel_management/view/screens/dashboard/screen4.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<Widget> _screens = [
    HomeScreen(),
    PartialPaymentScreen(),
    CheckinOut(),
    Screen4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.white,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        activeIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        icons: [
          Icons.home,
          Icons.payments,
          Icons.swap_vert,
          Icons.settings,
        ],
        // items: ite
        activeColor: Colors.black,
        inactiveColor: Colors.grey[600],
        splashColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 1'),
    );
  }
}
