// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:hotel_management/provider/room.dart';

class RoomsViewScreen extends ConsumerStatefulWidget {
  RoomsViewScreen({super.key});

  @override
  ConsumerState<RoomsViewScreen> createState() => _RoomsViewScreenState();
}

class _RoomsViewScreenState extends ConsumerState<RoomsViewScreen> {
  List<LastSevenDays> lastSevenDays = [];
  @override
  void initState() {
    getLastSevenDays();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(roomProvider).getRoomsReport();
    });
    super.initState();
  }

  final List<Rooms> rooms = [
    Rooms(roomNumber: 101, report: [
      Report(date: '01-06-2023', status: 'available'),
      Report(date: '02-06-2023', status: 'booked'),
      Report(date: '03-06-2023', status: 'available'),
      Report(date: '04-06-2023', status: 'checkedin'),
      Report(date: '05-06-2023', status: 'booked'),
      Report(date: '06-06-2023', status: 'booked'),
      Report(date: '07-06-2023', status: 'available'),
    ]),
    Rooms(roomNumber: 102, report: [
      Report(date: '01-06-2023', status: 'booked'),
      Report(date: '02-06-2023', status: 'available'),
      Report(date: '03-06-2023', status: 'booked'),
      Report(date: '04-06-2023', status: 'checkedin'),
      Report(date: '05-06-2023', status: 'available'),
      Report(date: '06-06-2023', status: 'booked'),
      Report(date: '07-06-2023', status: 'chekedin'),
    ]),
    Rooms(roomNumber: 103, report: [
      Report(date: '01-06-2023', status: 'checkedin'),
      Report(date: '02-06-2023', status: 'booked'),
      Report(date: '03-06-2023', status: 'booked'),
      Report(date: '04-06-2023', status: 'checkedin'),
      Report(date: '05-06-2023', status: 'available'),
      Report(date: '06-06-2023', status: 'available'),
      Report(date: '07-06-2023', status: 'chekedin'),
    ]),
    Rooms(roomNumber: 104, report: [
      Report(date: '01-06-2023', status: 'available'),
      Report(date: '02-06-2023', status: 'booked'),
      Report(date: '03-06-2023', status: 'available'),
      Report(date: '04-06-2023', status: 'checkedin'),
      Report(date: '05-06-2023', status: 'available'),
      Report(date: '06-06-2023', status: 'booked'),
      Report(date: '07-06-2023', status: 'chekedin'),
    ]),
    Rooms(roomNumber: 105, report: [
      Report(date: '01-06-2023', status: 'checkedin'),
      Report(date: '02-06-2023', status: 'booked'),
      Report(date: '03-06-2023', status: 'booked'),
      Report(date: '04-06-2023', status: 'checkedin'),
      Report(date: '05-06-2023', status: 'available'),
      Report(date: '06-06-2023', status: 'available'),
      Report(date: '07-06-2023', status: 'chekedin'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: ref.watch(roomProvider).isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: HorizontalDataTable(
                leftHandSideColumnWidth: 100,
                leftHandSideColBackgroundColor: Colors.grey.shade200,
                rightHandSideColumnWidth: 720,
                rightHandSideColBackgroundColor: Colors.grey.shade200,
                isFixedHeader: true,
                horizontalScrollPhysics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                headerWidgets: _getTitleWidget(),
                leftSideItemBuilder: _generateFirstColumnRow,
                rightSideItemBuilder: _generateRightHandSideColumnRow,
                itemCount: ref.read(roomProvider).reports.length,
                rowSeparatorWidget: Divider(
                  color: Colors.grey.shade300,
                  height: 2.0,
                  thickness: 1.0,
                ),
              ),
            ),
    );
  }

  List<Widget> _getTitleWidget() {
    List<Widget> titleWidgets = [];

    titleWidgets.add(_getTitleItemWidgetRoom(label: 'Room'));
    titleWidgets.add(_buildColumnSeparator());

    for (int i = 0; i < lastSevenDays.length; i++) {
      LastSevenDays day = lastSevenDays[i];

      titleWidgets.add(_getTitleItemWidget(label: day.dayName, date: day.day));
      titleWidgets.add(_buildColumnSeparator());
    }

    return titleWidgets;
  }

  Widget _getTitleItemWidgetRoom({required String label}) {
    return Container(
      width: 100,
      height: 60,
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _getTitleItemWidget({required String label, required int date}) {
    return Container(
      width: 100,
      height: 60,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 13,
              backgroundColor: Colors.blue.shade100,
              child: Text(date.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          const SizedBox(
            height: 4,
          ),
          Text(label, style: const TextStyle(color: Colors.black45)),
        ],
      ),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 56,
      alignment: Alignment.center,
      child: Text(ref.read(roomProvider).reports[index].roomNumber.toString()),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: ref
          .read(roomProvider)
          .reports[index]
          .report
          .map((e) => _sideColumnRowItemWidget(label: e.status))
          .toList(),
    );
  }

  Widget _sideColumnRowItemWidget({required String label}) {
    return Container(
      width: 101,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: label == 'available'
            ? Colors.white
            : label == 'booked'
                ? Colors.green.shade400
                : Colors.red.shade400,
        border: Border(
          left: BorderSide(
            color: const Color.fromRGBO(224, 224, 224, 1),
            width: 2.0,
          ),
        ),
      ),
      child: Text(
        label == 'available' ? 'Available' : '',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }

  Widget _buildColumnSeparator() {
    return const Divider(
      color: Colors.blue,
      height: 56,
      thickness: 1.0,
    );
  }

// Get seven days
  Future<List<LastSevenDays>> getLastSevenDays() async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    for (int i = 0; i < 7; i++) {
      DateTime newDate = date.add(Duration(days: i));
      String dayName = DateFormat('EEEE').format(newDate);
      lastSevenDays.add(LastSevenDays(dayName: dayName, day: newDate.day));
    }
    return lastSevenDays;
  }
}

class Rooms {
  int roomNumber;
  List<Report> report;
  Rooms({
    required this.roomNumber,
    required this.report,
  });
}

class Report {
  String date;
  String status;
  Report({
    required this.date,
    required this.status,
  });
}

class LastSevenDays {
  String dayName;
  int day;
  LastSevenDays({
    required this.dayName,
    required this.day,
  });
}
