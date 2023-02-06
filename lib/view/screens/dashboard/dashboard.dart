import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/controller/auth_controller.dart';
import 'package:hotel_management/controller/dashboard.dart';
import 'package:hotel_management/models/dashboard.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/widgets/dashboard_tile.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'The Dream House',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: ref
              .read(dashboardProvider)
              .getDashboardInfo(ref.read(authProvider).userData.hotel!.id),
          builder: (context, AsyncSnapshot<DashboardInfo?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final DashboardInfo? dashboardInfo = snapshot.data;
              if (dashboardInfo == null) {
                return Center(child: Text('Something went wrong'));
              }
              return ListView(
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      DashboardTile(
                        title: 'Total Rooms',
                        count: dashboardInfo.summary.totalRooms,
                        onTap: () {},
                      ),
                      DashboardTile(
                        title: 'Today Bookings',
                        count: dashboardInfo.summary.todayBookings,
                        onTap: () {},
                      ),
                      DashboardTile(
                        title: 'Booked Rooms',
                        count: dashboardInfo.summary.bookedRooms,
                        onTap: () {},
                      ),
                      DashboardTile(
                        title: 'Available Rooms',
                        count: dashboardInfo.summary.availableRooms,
                        onTap: () {
                          Navigator.pushNamed(context, Routes.availableRoom);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text('Recent Booking'),
                  SizedBox(height: 16),
                  Column(
                    children: List.generate(
                      20,
                      (index) {
                        return ListTile(
                          title: Text('Booking ${index + 1}'),
                          subtitle: Text('Date: ${DateTime.now().toLocal()}'),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: SizedBox(
                child: Shimmer.fromColors(
                    direction: ShimmerDirection.ltr,
                    child: Container(
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              DashboardTile(
                                title: 'Total Rooms',
                                count: 10,
                                onTap: () {},
                              ),
                              DashboardTile(
                                title: 'Today Bookings',
                                count: 10,
                                onTap: () {},
                              ),
                              DashboardTile(
                                title: 'Booked Rooms',
                                count: 10,
                                onTap: () {},
                              ),
                              DashboardTile(
                                title: 'Available Rooms',
                                count: 10,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.availableRoom);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Container(
                            height: 10,
                            width: 200,
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          Column(
                            children: List.generate(
                              4,
                              (index) {
                                return Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 10,
                                          width: 150,
                                          color: Colors.white),
                                      SizedBox(height: 5),
                                      Container(
                                        height: 10,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    baseColor: Theme.of(context).highlightColor,
                    highlightColor: Theme.of(context).colorScheme.background),
              ),
            );
          },
        ),
      ),
    );
  }
}
