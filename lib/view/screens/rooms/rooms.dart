import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/search_room_controller.dart';
import 'package:somudro_bilash_hotel/view/widgets/rooms/room_tile.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  _RoomsScreenState createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('Rooms'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Floor 1',
              ),
              Tab(
                text: 'Floor 2',
              ),
              Tab(
                text: 'Floor 3',
              ),
              Tab(
                text: 'Floor 4',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GetBuilder<SearchRoomController>(
              builder: (searchController) {
                return GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
            ),
            GetBuilder<SearchRoomController>(
              builder: (searchController) {
                return GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
            ),
            GetBuilder<SearchRoomController>(
              builder: (searchController) {
                return GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
            ),
            GetBuilder<SearchRoomController>(
              builder: (searchController) {
                return GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
            ),
            GetBuilder<SearchRoomController>(
              builder: (searchController) {
                return GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
            ),
          ],
        ),
      ),
    );
  }
}
