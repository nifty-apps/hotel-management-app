import 'package:flutter/material.dart';
import 'package:samudra_bilash_hotel/controller/paging_controller.dart';
import 'package:samudra_bilash_hotel/controller/search_room_controller.dart';
import 'package:samudra_bilash_hotel/view/screens/floor/floor.dart';
import 'package:samudra_bilash_hotel/view/widgets/dashboard/date_range.dart';
import 'package:samudra_bilash_hotel/view/widgets/dashboard/room_availabel_info.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Get.find<SearchroomController>().getAllRooms();
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                //color:Colors.green,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Available Room',
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
              SizedBox(
                height: 20,
              ),
              RoomAvailableInfo(),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
