// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samudra_bilash_hotel/controller/auth_controller.dart';
import 'package:samudra_bilash_hotel/controller/paging_controller.dart';
import 'package:samudra_bilash_hotel/controller/search_room_controller.dart';
import 'package:samudra_bilash_hotel/view/screens/dashboard/dashboard.dart';
import 'package:samudra_bilash_hotel/view/screens/floor/floor.dart';

import 'package:samudra_bilash_hotel/view/screens/login_screen/login_page.dart';
import 'package:samudra_bilash_hotel/view/screens/revenue/revenue.dart';

class HomeScreen extends StatelessWidget {
  PagingController pageController = Get.put(PagingController());
  SearchroomController searchController = Get.put(SearchroomController());
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Get.find<PagingController>().changePage('dashboard');
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Container(
          child: GetBuilder<PagingController>(
            builder: (pageController) {
              if (pageController.currentPage == 'dashboard') {
                return Text(
                  'Dash Board',
                  style: TextStyle(color: Colors.white),
                );
              } else {
                return Text(
                  'Floors',
                  style: TextStyle(color: Colors.white),
                );
              }
            },
          ),
        ),
        actions: [
          GetBuilder<PagingController>(builder: (pageController) {
            if (pageController.currentPage == 'dashboard') {
              return InkWell(
                onTap: () {
                  Get.find<PagingController>().changePage('floor');
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15, right: 10),
                  padding: EdgeInsets.only(left: 4, right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.white,
                  ),
                  height: 20,
                  child: Center(
                    child: Text(
                      'Go to floor',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ),
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  Get.find<PagingController>().changePage('dashboard');
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15, right: 10),
                  padding: EdgeInsets.only(left: 4, right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.white,
                  ),
                  height: 20,
                  child: Center(
                    child: Text(
                      'Go to Dashboard',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ),
                ),
              );
            }
          })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'Admin Name',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.password,
              ),
              title: const Text('Change Password'),
              onTap: () {},
            ),
            /*  ListTile(
              leading: Icon(Icons.category),
              title: const Text('Room Type'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Rooms'),
              onTap: () {},
            ), */
            ListTile(
              leading: Icon(Icons.attach_money_sharp),
              title: const Text('Todays Revenue'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RevenuePage(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () async {
                //  var db = new DatabaseHelper();
                //   await db.deleteUsers();
                //   var isLoggedIn = await db.isLoggedIn();
                //   if (!isLoggedIn) {
                //     Get.to(LoginPage());
                //   }
                bool success = await controller.logout();
                if (success) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false);
                }
              },
            ),
          ],
        ),
      ),
      body: /* UserRegister() */ /* Floors() */ GetBuilder<PagingController>(
        builder: (pageController) {
          if (pageController.currentPage == 'dashboard') {
            return Dashboard();
          } else {
            return Floors();
          }
        },
      ),
    );
  }
}
