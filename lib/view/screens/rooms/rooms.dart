import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_management/model/room_type_model.dart';
import 'package:hotel_management/view/widgets/rooms/room_tile.dart';

class RoomsScreen extends StatelessWidget {
  final RoomType roomType;

  const RoomsScreen({Key? key, required this.roomType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(roomType.name),
          bottom: TabBar(
            isScrollable: true,
            tabs:[

            ],
            // Get.find<RoomController>()
            //     .roomsByFloor
            //     .keys
            //     .map(
            //       (e) => Tab(
            //         text: e,
            //       ),
            //     )
            //     .toList(),
          ),
        ),
        body: GridView.builder(
                        padding: EdgeInsets.all(20),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 4 / 2.5,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount:5,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(); 
                          //  RoomTile(
                          //   room: searchController.roomsByFloor[e]![index],
                          //   fromDate: searchController.fromDate,
                          //   toDate: searchController.toDate,
                          // );
                        },
                      )
        // TabBarView(
        //   children: Get.find<RoomController>()
        //       .roomsByFloor
        //       .keys
        //       .map((e) => GetBuilder<RoomController>(
        //             builder: (searchController) {
        //               return 
        //             },
        //           ))
        //       .toList(),
        // ),
      ),
    );
  }
}
