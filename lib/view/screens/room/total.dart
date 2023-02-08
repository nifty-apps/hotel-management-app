import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/room.dart';
import 'package:hotel_management/models/room.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/widgets/rooms/room_card.dart';

class TotalRoomSrceen extends ConsumerWidget {
  const TotalRoomSrceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Total Rooms',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.addRoom);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ref.read(roomProvider).getRoomList(),
        builder: (context, AsyncSnapshot<List<Room>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data;

            if (data == null) {
              return Center(child: Text('Something went wrong'));
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.pushNamed(
                        context, Routes.bookingRoom,
                        arguments: data[index].id
                      );
                    },
                    child: RoomCard(room: data[index]),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
