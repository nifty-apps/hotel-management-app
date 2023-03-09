import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  // List<NavigationItem> items = [
  //   NavigationItem(
  //     icon: Icon(Icons.home),
  //     title: Text('Home'),
  //     color: Colors.indigo,
  //   ),
  //   NavigationItem(
  //     icon: Icon(Icons.search),
  //     title: Text('Search'),
  //     color: Colors.pink,
  //   ),
  //   NavigationItem(
  //     icon: Icon(Icons.notifications),
  //     title: Text('Notifications'),
  //     color: Colors.yellow,
  //   ),
  //   NavigationItem(
  //     icon: Icon(Icons.settings),
  //     title: Text('Settings'),
  //     color: Colors.teal,
  //   ),
  //   NavigationItem(
  //     icon: Icon(Icons.person),
  //     title: Text('Profile'),
  //     color: Colors.cyan,
  //   ),
  // ];

  List<Widget> _screens = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
    Screen5()
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
          Icons.payment,
          Icons.notifications,
          Icons.settings,
        ],
        // items: ite
        activeColor: Colors.black,
        inactiveColor: Colors.grey[600],
        splashColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            
          });
        },
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

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 2'),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 3'),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 4'),
    );
  }
}

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 5'),
    );
  }
}
