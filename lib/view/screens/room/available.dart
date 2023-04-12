// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hotel_management/routes.dart';

// class AvailableRoomScreen extends ConsumerWidget {
//   const AvailableRoomScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme:
//             IconThemeData(color: Theme.of(context).colorScheme.secondary),
//         backgroundColor: Theme.of(context).colorScheme.background,
//         title: Text(
//           'Available Rooms',
//           style: TextStyle(
//             color: Theme.of(context).colorScheme.secondary,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: ListView.builder(
//         itemCount: 20,
//         itemBuilder: (context, index) => Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 10,
//             vertical: 10,
//           ),
//           child: InkWell(
//               borderRadius: BorderRadius.circular(10),
//               onTap: () {
//                 Navigator.pushNamed(
//                   context, Routes.bookingRoom,
//                   // arguments: ['244', false]
//                 );
//               },
//               child: Container(
//                 child: Center(
//                   child: Text('Available Rooms'),
//                 ),
//               )),
//         ),
//       ),
//     );
//   }
// }
