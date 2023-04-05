import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/available_room.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/date_picker_button.dart';
import 'package:hotel_management/view/base/search_button.dart';
import 'package:shimmer/shimmer.dart';

class NewBookingScreen extends ConsumerStatefulWidget {
  NewBookingScreen({super.key});

  @override
  ConsumerState<NewBookingScreen> createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends ConsumerState<NewBookingScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();

  List<AvailableRoom> selectedRooms = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookingProvider).getAvailableRooms(
            fromDate: fromDate!..subtract(Duration(days: 1)),
            toDate: toDate!,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Booking'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'From Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              InkWell(
                                  onTap: () async {
                                    final date = await selectDate(context);
                                    setState(() {
                                      fromDate = date;
                                    });
                                  },
                                  child: DatePickerButton(date: fromDate)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'To Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              InkWell(
                                onTap: () async {
                                  final date = await selectDate(context);
                                  setState(() {
                                    toDate = date;
                                  });
                                },
                                child: DatePickerButton(date: toDate),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SearchButton(
                    onPressed: () async {
                      selectedRooms.clear();
                      ref.read(bookingProvider).getAvailableRooms(
                            fromDate: fromDate!.subtract(Duration(days: 1)),
                            toDate: toDate!,
                          );
                    },
                  )
                ],
              ),
            ),
            Spacer(),
            ref.watch(bookingProvider).isLoading
                ? shimmerWidget()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: ref.watch(bookingProvider).availableRooms.length == 0
                        ? Center(
                            child: Text(
                              'No Rooms Available',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Room Types',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 250,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount: ref
                                      .watch(bookingProvider)
                                      .availableRooms
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final AvailableRoom room = ref
                                        .watch(bookingProvider)
                                        .availableRooms[index];

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (selectedRooms.contains(room)) {
                                            selectedRooms.remove(room);
                                          } else {
                                            selectedRooms.add(room);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        margin: EdgeInsets.all(5),
                                        height: 100,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: selectedRooms.contains(room)
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Color(0xFF2DCC70),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ref
                                                  .watch(bookingProvider)
                                                  .availableRooms[index]
                                                  .type,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                ImageIcon(
                                                  AssetImage(
                                                      'assets/icons/bed.png'),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  ref
                                                      .watch(bookingProvider)
                                                      .availableRooms[index]
                                                      .count
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Spacer(),
                              selectedRooms.length != 0
                                  ? CustomButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.choiceRooms,
                                          arguments: [
                                            selectedRooms,
                                            fromDate,
                                            toDate
                                          ],
                                        );
                                      },
                                      buttonText: 'Next',
                                      width: double.infinity,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                  )
          ],
        ),
      ),
    );
  }

  Widget shimmerWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.background,
              highlightColor: Theme.of(context).highlightColor,
              child: Container(
                height: 10,
                width: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(5),
                ),
              )),
          SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.background,
            highlightColor: Theme.of(context).highlightColor,
            child: Container(
              height: 250,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    margin: EdgeInsets.all(5),
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
