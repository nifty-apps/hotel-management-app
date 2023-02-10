import 'package:flutter/material.dart';
import 'package:hotel_management/models/room.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/util/app_constants.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  RoomCard({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Text(
                room.number,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 16),
          Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.roomType.toTitleCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  room.floor,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(height: 10),
                Text(
                  'BDT ${room.rent}',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.bookingRoom,
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
