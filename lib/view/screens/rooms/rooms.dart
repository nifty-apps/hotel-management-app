import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/search_room_controller.dart';
import 'package:somudro_bilash_hotel/model/room_type_model.dart';
import 'package:somudro_bilash_hotel/view/widgets/rooms/room_tile.dart';

class RoomsScreen extends StatelessWidget {
  final RoomType roomType;

  const RoomsScreen({Key? key, required this.roomType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: roomType.floors.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(roomType.name),
          bottom: TabBar(
            isScrollable: true,
            tabs: roomType.floors
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: roomType.floors
              .map((e) => GetBuilder<SearchRoomController>(
                    builder: (searchController) {
                      return GridView.builder(
                        padding: EdgeInsets.all(20),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 4 / 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: searchController.availableRoom.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return RoomTile(
                            room: searchController.availableRoom[index],
                            fromDate: searchController.fromSelectedDate,
                            toDate: searchController.toSelectedDate,
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
