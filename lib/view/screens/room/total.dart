import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/routes.dart';

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
              Navigator.pushNamed(context, Routes.addRoom,
                  arguments: [false, null]);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Text('Total Rooms'),
      ),
    );
  }
}
