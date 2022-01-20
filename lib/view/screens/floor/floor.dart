import 'package:flutter/material.dart';
import 'package:samudra_bilash_hotel/view/screens/floor/single_floor.dart';

class Floors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        SingleFloor(
          floorNumber: '1st Floor',
        ),
        SingleFloor(
          floorNumber: '2nd Floor',
        ),
        SingleFloor(
          floorNumber: '3rd Floor',
        ),
        SingleFloor(
          floorNumber: '4th Floor',
        ),
      ],
    );
  }
}
