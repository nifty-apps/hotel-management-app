// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hotel_management/models/booking.dart';
// import 'package:hotel_management/models/dashboard.dart';
// import 'package:hotel_management/provider/auth_provider.dart';
// import 'package:hotel_management/provider/dashboard.dart';
// import 'package:hotel_management/provider/room.dart';
// import 'package:hotel_management/routes.dart';
// import 'package:hotel_management/util/app_constants.dart';
// import 'package:hotel_management/view/widgets/dashboard_tile.dart';
// import 'package:intl/intl.dart';
// import 'package:shimmer/shimmer.dart';

// class DashboardScreen extends ConsumerStatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends ConsumerState<DashboardScreen> {
//   @override
//   void initState() {
//     super.initState();
//     ref.read(roomProvider).recentBookingRooms();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           ref.read(authProvider).userData?.hotel?.name ?? 'Hotel Management',
//           style: TextStyle(color: Colors.black),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, Routes.profile);
//             },
//             icon: Icon(
//               Icons.person,
//               size: 30,
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           )
//         ],
//       ),
//       body: Container(
//         child: FutureBuilder(
//           future: ref.read(dashboardProvider).getDashboardInfo(),
//           builder: (context, AsyncSnapshot<DashboardInfo?> snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               final DashboardInfo? dashboardInfo = snapshot.data;
//               if (dashboardInfo == null) {
//                 return Center(child: Text('Something went wrong'));
//               }
//               return ListView(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 children: [
//                   GridView.count(
//                     crossAxisCount: 2,
//                     shrinkWrap: true,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       DashboardTile(
//                         title: 'Total Rooms',
//                         count: dashboardInfo.summary.totalRooms,
//                         onTap: () {
//                           Navigator.pushNamed(context, Routes.totalRooms);
//                         },
//                       ),
//                       DashboardTile(
//                         title: 'Today Revenue',
//                         count: dashboardInfo.summary.todayCheckIn,
//                         onTap: () {},
//                       ),
//                       DashboardTile(
//                         title: 'Today Bookings',
//                         count: dashboardInfo.summary.todayBookings,
//                         onTap: () {
//                           ref.read(roomProvider).todayBookingRooms();
//                           Navigator.pushNamed(
//                               context, Routes.todayBookingsRoom);
//                         },
//                       ),
//                       DashboardTile(
//                         title: 'Today Checking',
//                         count: dashboardInfo.summary.todayCheckIn,
//                         onTap: () {
//                           // Navigator.pushNamed(context, Routes.availableRoom);
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 24),
//                   Text('Recent Bookings'),
//                   SizedBox(height: 16),
//                   FutureBuilder(
//                     future: ref.read(roomProvider).recentBookingRooms(),
//                     builder: (context, AsyncSnapshot<List<Booking>?> snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         final bookings = snapshot.data;
//                         if (bookings == null)
//                           return Center(
//                             child: Text('Something went wrong!'),
//                           );
//                         return Column(
//                           children: List.generate(
//                             bookings.length,
//                             (index) {
//                               String roomType =
//                                   bookings[index].room['roomType'];
//                               return Container(
//                                 margin: EdgeInsets.symmetric(vertical: 5),
//                                 height: MediaQuery.of(context).size.height / 12,
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).highlightColor,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: InkWell(
//                                   borderRadius: BorderRadius.circular(10),
//                                   onTap: () {},
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Flexible(
//                                         flex: 1,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary
//                                                 .withOpacity(0.7),
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(10),
//                                               bottomLeft: Radius.circular(10),
//                                               topRight: Radius.circular(5),
//                                               bottomRight: Radius.circular(5),
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               bookings[index].room['number'],
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .titleMedium!
//                                                   .copyWith(
//                                                     color: Theme.of(context)
//                                                         .colorScheme
//                                                         .secondary,
//                                                   ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 10),
//                                       Flexible(
//                                         flex: 3,
//                                         child: Container(
//                                           padding: EdgeInsets.only(right: 10),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 roomType.toTitleCase(),
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleSmall!
//                                                     .copyWith(
//                                                       color: Theme.of(context)
//                                                           .colorScheme
//                                                           .secondary,
//                                                     ),
//                                               ),
//                                               Text(
//                                                 bookings[index].customer.name,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodySmall!
//                                                     .copyWith(
//                                                       color: Theme.of(context)
//                                                           .colorScheme
//                                                           .primary,
//                                                     ),
//                                               ),
//                                               Container(
//                                                 width: double.infinity,
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Text(
//                                                       'Check In: ${DateFormat.yMMMd().format(bookings[index].checkIn.toLocal())}',
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodySmall!
//                                                           .copyWith(
//                                                             color: Theme.of(
//                                                                     context)
//                                                                 .colorScheme
//                                                                 .secondary,
//                                                             fontSize: 11,
//                                                           ),
//                                                     ),
//                                                     Text(
//                                                       ' ${DateFormat.yMMMd().format(bookings[index].checkOut.toLocal())}',
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodySmall!
//                                                           .copyWith(
//                                                             color: Theme.of(
//                                                                     context)
//                                                                 .errorColor,
//                                                             fontSize: 11,
//                                                           ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       }
//                       return Center(
//                         child: Text('Recent bookings...'),
//                       );
//                     },
//                   ),
//                 ],
//               );
//             }
//             return Center(
//               child: SizedBox(
//                 child: Shimmer.fromColors(
//                     direction: ShimmerDirection.ltr,
//                     child: Container(
//                       child: ListView(
//                         physics: NeverScrollableScrollPhysics(),
//                         children: [
//                           GridView.count(
//                             crossAxisCount: 2,
//                             shrinkWrap: true,
//                             mainAxisSpacing: 10,
//                             crossAxisSpacing: 10,
//                             physics: NeverScrollableScrollPhysics(),
//                             children: [
//                               DashboardTile(
//                                 title: 'Total Rooms',
//                                 count: 10,
//                                 onTap: () {},
//                               ),
//                               DashboardTile(
//                                 title: 'Today Revenue',
//                                 count: 10,
//                                 onTap: () {},
//                               ),
//                               DashboardTile(
//                                 title: 'Today Bookings',
//                                 count: 10,
//                                 onTap: () {},
//                               ),
//                               DashboardTile(
//                                 title: 'Today Checking',
//                                 count: 10,
//                                 onTap: () {
//                                   // Navigator.pushNamed(
//                                   //     context, Routes.availableRoom);
//                                 },
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 24),
//                           Container(
//                             height: 10,
//                             width: 200,
//                             color: Colors.white,
//                           ),
//                           SizedBox(height: 16),
//                           Column(
//                             children: List.generate(
//                               4,
//                               (index) {
//                                 return Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: 10,
//                                         width: 150,
//                                         color: Colors.white,
//                                       ),
//                                       SizedBox(height: 5),
//                                       Container(
//                                         height: 10,
//                                         width: double.infinity,
//                                         color: Colors.white,
//                                       ),
//                                       SizedBox(height: 20),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     baseColor: Theme.of(context).highlightColor,
//                     highlightColor: Theme.of(context).colorScheme.background),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }