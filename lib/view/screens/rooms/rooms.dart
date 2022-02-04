import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/room_controller.dart';
import 'package:somudro_bilash_hotel/model/room_type_model.dart';
import 'package:somudro_bilash_hotel/view/widgets/rooms/room_tile.dart';

class RoomsScreen extends StatelessWidget {
  final RoomType roomType;

  const RoomsScreen({Key? key, required this.roomType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Get.find<RoomController>().roomsByFloor.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(roomType.name),
          bottom: TabBar(
            isScrollable: true,
            tabs: Get.find<RoomController>()
                .roomsByFloor
                .keys
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: Get.find<RoomController>()
              .roomsByFloor
              .keys
              .map((e) => GetBuilder<RoomController>(
                    builder: (searchController) {
                      return GridView.builder(
                        padding: EdgeInsets.all(20),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 4 / 2.5,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: searchController.roomsByFloor[e]!.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return RoomTile(
                            room: searchController.roomsByFloor[e]![index],
                            fromDate: searchController.fromDate,
                            toDate: searchController.toDate,
                          );
                        },
                      );
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
