import 'package:flutter/material.dart';

class RoomAvailableInfo extends StatefulWidget {
  const RoomAvailableInfo({Key? key}) : super(key: key);

  @override
  _RoomAvailableInfoState createState() => _RoomAvailableInfoState();
}

class _RoomAvailableInfoState extends State<RoomAvailableInfo> {
  @override
  Widget build(BuildContext context) {
    List<String> rooms = [
      'Honeymoon Suite',
      'Family Suite',
      'Three Bed',
      'Couple Bed',
      'Twin Couple Bed(AC)'
    ];
    List<String> roomsNo = ['4', '8', '10', '5', '12'];
    return Container(
      
      height: 270,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: ListView.builder(
        itemCount: rooms.length,
        shrinkWrap: true,
        physics:NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Card(
              elevation: 3,
              color: Colors.white,
              child: Container(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rooms[index],
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      roomsNo[index],
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
