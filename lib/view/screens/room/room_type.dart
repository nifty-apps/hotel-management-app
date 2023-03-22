import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/room_type.dart';
import 'package:hotel_management/provider/room_type.dart';
import 'package:hotel_management/routes.dart';
import 'package:shimmer/shimmer.dart';

class RoomTypeListScreen extends ConsumerStatefulWidget {
  RoomTypeListScreen({super.key});
  @override
  ConsumerState<RoomTypeListScreen> createState() => _RoomTypeListScreenState();
}

class _RoomTypeListScreenState extends ConsumerState<RoomTypeListScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Type'),
        automaticallyImplyLeading: true,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            RoomType roomType = RoomType(
              id: '',
              type: '',
              rent: 0,
              description: '',
            );
            Navigator.pushNamed(
              context,
              Routes.addRoomType,
              arguments: roomType,
            ).then((_) {
              setState(() {});
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            FutureBuilder(
              future: ref.read(roomTypeProvider).getRoomTypeList(),
              builder: (context, AsyncSnapshot<List<RoomType>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final List<RoomType> roomTypes = snapshot.data ?? [];
                  if (roomTypes.length == 0) {
                    return Center(
                      child: Text('No Room Type Found'),
                    );
                  }
                  return Expanded(
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              'Room Type List',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: roomTypes.length,
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
                                      RoomType roomType = RoomType(
                                        id: roomTypes[index].id,
                                        type: roomTypes[index].type,
                                        rent: roomTypes[index].rent,
                                        description:
                                            roomTypes[index].description,
                                      );
                                      Navigator.pushNamed(
                                        context,
                                        Routes.addRoomType,
                                        arguments: roomType,
                                      ).then(
                                        (_) => setState(() {}),
                                      );
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 20,
                                      child: Center(
                                        child: Text(index.toString()),
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    title: Text(roomTypes[index].type),
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
                return shimmerWidget();
              },
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
                    height: 10,
                    width: 200,
                    color: Theme.of(context).colorScheme.background),
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
                        onTap: () => Navigator.pushNamed(
                            context, Routes.addRoomType,
                            arguments: true),
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          radius: 20,
                          child: Center(
                            child: Text(''),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Container(
                          height: 15,
                          width: 350,
                          color: Theme.of(context).colorScheme.background,
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
