import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/booking.dart';
import 'package:hotel_management/models/dashboard.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/provider/dashboard.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Icon(Icons.hotel),
        title: Text('Home'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            FutureBuilder(
              future: ref.read(dashboardProvider).getDashboardInfo(
                  fromDate: DateTime.now().subtract(Duration(days: 1)),
                  toDate: DateTime.now()),
              builder: (context, AsyncSnapshot<DashboardInfo?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final DashboardInfo dashboardInfo = snapshot.data!;
                  return Flexible(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'assets/icons/person.png'),
                                              ),
                                              SizedBox(width: 16),
                                              Text(
                                                dashboardInfo.todayBookings
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Today Bookings',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: double.infinity,
                                    width: 3,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'assets/icons/checked_in.png'),
                                              ),
                                              SizedBox(width: 16),
                                              Text(
                                                dashboardInfo.todayBooked
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Today Booked',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 3,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'assets/icons/booked_room.png'),
                                              ),
                                              SizedBox(width: 16),
                                              Text(
                                                dashboardInfo.todayCheckedIn
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Today Checked In',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(
                                    thickness: 3,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'assets/icons/available_rooms.png'),
                                              ),
                                              SizedBox(width: 16),
                                              Text(
                                                dashboardInfo.todayAvailableRoom
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Available Rooms',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 3,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: ListTile(
                                title: Text(
                                  'Today Collections',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                trailing: Image.asset('assets/icons/arrow.png'),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/icons/tk.png'),
                                      SizedBox(width: 10),
                                      Text(
                                        dashboardInfo.todayCollection
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return dashboardShimmerWidget(context);
              },
            ),
            FutureBuilder(
              future: ref.read(bookingProvider).getRecentBookings(),
              builder: (context, AsyncSnapshot<List<Bookings>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final bookingList = snapshot.data;
                  return Flexible(
                    flex: 4,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: bookingList!.length == 0
                          ? Center(
                              child: Text(
                                'No booking found!',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
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
                                    'Recent Booking',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: ListView.builder(
                                    itemCount: bookingList.length,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        Divider(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          thickness: 3,
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.person),
                                          trailing: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          title: Text(
                                              bookingList[index].customer.name),
                                          subtitle: Text(bookingList[index]
                                              .customer
                                              .phone),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                    ),
                  );
                }
                return recenShimmerWidget(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget recenShimmerWidget(BuildContext context) {
    return Flexible(
      flex: 4,
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
            Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.background,
              highlightColor: Theme.of(context).highlightColor,
              child: Container(
                margin: EdgeInsets.all(20),
                height: 10,
                width: 100,
                color: Theme.of(context).colorScheme.background,
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
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Container(
                          height: 10,
                          width: 200,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        subtitle: Container(
                          height: 10,
                          width: 100,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget dashboardShimmerWidget(BuildContext context) {
    return Flexible(
      flex: 4,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor:
                                      Theme.of(context).colorScheme.background,
                                  highlightColor:
                                      Theme.of(context).highlightColor,
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Shimmer.fromColors(
                                  baseColor:
                                      Theme.of(context).colorScheme.background,
                                  highlightColor:
                                      Theme.of(context).highlightColor,
                                  child: Container(
                                    height: 10,
                                    width: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Shimmer.fromColors(
                              baseColor:
                                  Theme.of(context).colorScheme.background,
                              highlightColor: Theme.of(context).highlightColor,
                              child: Container(
                                height: 10,
                                width: 40,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Theme.of(context).colorScheme.background,
                      highlightColor: Theme.of(context).highlightColor,
                      child: Container(
                        height: double.infinity,
                        width: 3,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor:
                                      Theme.of(context).colorScheme.background,
                                  highlightColor:
                                      Theme.of(context).highlightColor,
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Shimmer.fromColors(
                                  baseColor:
                                      Theme.of(context).colorScheme.background,
                                  highlightColor:
                                      Theme.of(context).highlightColor,
                                  child: Container(
                                    height: 10,
                                    width: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Shimmer.fromColors(
                              baseColor:
                                  Theme.of(context).colorScheme.background,
                              highlightColor: Theme.of(context).highlightColor,
                              child: Container(
                                height: 10,
                                width: 40,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 3,
              color: Theme.of(context).colorScheme.background,
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor:
                                      Theme.of(context).colorScheme.background,
                                  highlightColor:
                                      Theme.of(context).highlightColor,
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Shimmer.fromColors(
                                  baseColor:
                                      Theme.of(context).colorScheme.background,
                                  highlightColor:
                                      Theme.of(context).highlightColor,
                                  child: Container(
                                    height: 10,
                                    width: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Shimmer.fromColors(
                              baseColor:
                                  Theme.of(context).colorScheme.background,
                              highlightColor: Theme.of(context).highlightColor,
                              child: Container(
                                height: 10,
                                width: 40,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 3,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor:
                                      Theme.of(context).colorScheme.background,
                                  highlightColor:
                                      Theme.of(context).highlightColor,
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Shimmer.fromColors(
                                  baseColor:
                                      Theme.of(context).colorScheme.background,
                                  highlightColor:
                                      Theme.of(context).highlightColor,
                                  child: Container(
                                    height: 10,
                                    width: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Shimmer.fromColors(
                              baseColor:
                                  Theme.of(context).colorScheme.background,
                              highlightColor: Theme.of(context).highlightColor,
                              child: Container(
                                height: 10,
                                width: 40,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 3,
              color: Theme.of(context).colorScheme.background,
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.background,
                  highlightColor: Theme.of(context).highlightColor,
                  child: ListTile(
                    title: Container(
                      height: 10,
                      width: 80,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    trailing: Container(
                      height: 40,
                      width: 40,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Theme.of(context).colorScheme.background,
                            highlightColor: Theme.of(context).highlightColor,
                            child: Container(
                              height: 24,
                              width: 24,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          SizedBox(width: 10),
                          Shimmer.fromColors(
                            baseColor: Theme.of(context).colorScheme.background,
                            highlightColor: Theme.of(context).highlightColor,
                            child: Container(
                              height: 10,
                              width: 40,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
