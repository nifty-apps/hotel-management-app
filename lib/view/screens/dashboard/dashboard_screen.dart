import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/auth_controller.dart';
import 'package:somudro_bilash_hotel/controller/room_type_controller.dart';
import 'package:somudro_bilash_hotel/controller/search_room_controller.dart';
import 'package:somudro_bilash_hotel/view/screens/login_screen/login_page.dart';
import 'package:somudro_bilash_hotel/view/screens/revenue/revenue.dart';
import 'package:somudro_bilash_hotel/view/widgets/dashboard/date_range.dart';
import 'package:somudro_bilash_hotel/view/widgets/dashboard/room_type_info_tile.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<SearchRoomController>().getAllRooms();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Dashboard'),
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case 0:
                  break;
                case 1:
                  Get.to(() => RevenuePage());
                  break;
                case 2:
                  bool success = await Get.find<AuthController>().logout();
                  if (success) Get.offAll(LoginPage());
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(width: 10.0),
                    Text('Change Password'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(width: 10.0),
                    Text('Revenue'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(width: 10.0),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'Select Date',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  DateRange(),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await Get.find<RoomTypeController>().getInfo();
              },
              icon: Icon(Icons.search),
              label: Text('Search'),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: GetBuilder<RoomTypeController>(builder: (controller) {
                  return controller.isLoading
                      ? Center(
                          // heightFactor: 5.0,
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.roomInfo.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RoomTypeInfoTile(
                              roomType:
                                  controller.roomInfo.keys.elementAt(index),
                              roomAvailable:
                                  controller.roomInfo.values.elementAt(index),
                            );
                          },
                        );
                }),
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
