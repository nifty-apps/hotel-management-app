import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/room.dart';
import 'package:hotel_management/provider/room.dart';
import 'package:hotel_management/routes.dart';
import 'package:shimmer/shimmer.dart';

class RoomListScreen extends ConsumerStatefulWidget {
  RoomListScreen({super.key});
  @override
  ConsumerState<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends ConsumerState<RoomListScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rooms'),
        automaticallyImplyLeading: true,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Room roomData = Room(
            id: null,
            number: null,
            roomType: null,
          );
          Navigator.pushNamed(context, Routes.addRoom, arguments: roomData)
              .then((_) {
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    // SearchTextFormField(
                    //   controller: searchController,
                    //   hintText: 'Enter enter room number',
                    //   onFieldSubmitted: (value) {
                    //     ref
                    //         .read(roomProvider)
                    //         .getRoomList(searchController.text.trim());
                    //   },
                    // ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ref.watch(roomProvider).isLoading
                ? shimmerWidget()
                : Flexible(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: ref.read(roomProvider).rooms.length == 0
                          ? Center(
                              child: Text(
                                'Sorry, Room not found!',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Text(
                                    'Room List',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: ListView.builder(
                                    itemCount:
                                        ref.read(roomProvider).rooms.length,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        Divider(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          thickness: 3,
                                        ),
                                        ListTile(
                                          onTap: () {
                                            Room roomData = Room(
                                              id: ref
                                                  .read(roomProvider)
                                                  .rooms[index]
                                                  .id,
                                              number: ref
                                                  .read(roomProvider)
                                                  .rooms[index]
                                                  .number,
                                              roomType: ref
                                                  .read(roomProvider)
                                                  .rooms[index]
                                                  .roomType,
                                            );
                                            Navigator.pushNamed(
                                              context,
                                              Routes.addRoom,
                                              arguments: roomData,
                                            ).then((_) {
                                              setState(() {});
                                            });
                                          },
                                          leading: Container(
                                            height: 40,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.green,
                                            ),
                                            child: Center(
                                              child: Text(
                                                ref
                                                    .read(roomProvider)
                                                    .rooms[index]
                                                    .number
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          trailing: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          title: Text(
                                            ref
                                                        .read(roomProvider)
                                                        .rooms[index]
                                                        .roomType!
                                                        .type !=
                                                    null
                                                ? ref
                                                    .read(roomProvider)
                                                    .rooms[index]
                                                    .roomType!
                                                    .type!
                                                : '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget shimmerWidget() {
    return Flexible(
      flex: 6,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.background,
                highlightColor: Theme.of(context).highlightColor,
                child: Container(
                  height: 1,
                  width: 220,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Theme.of(context).colorScheme.background,
                      highlightColor: Theme.of(context).highlightColor,
                      child: Divider(
                        color: Theme.of(context).colorScheme.background,
                        thickness: 3,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Theme.of(context).colorScheme.background,
                      highlightColor: Theme.of(context).highlightColor,
                      child: ListTile(
                        onTap: () {},
                        leading: Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.background,
                          highlightColor: Theme.of(context).highlightColor,
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).colorScheme.background,
                            ),
                            child: Center(
                              child: Text(''),
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.background,
                          highlightColor: Theme.of(context).highlightColor,
                          child: Container(
                            height: 10,
                            width: 250,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
