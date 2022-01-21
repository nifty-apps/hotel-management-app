import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/search_room_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class DateRange extends StatefulWidget {
  @override
  _DateRangeState createState() => _DateRangeState();
}

class _DateRangeState extends State<DateRange> {
  DateTime fromSelectedDate = DateTime.now();
  DateTime toSelectedDate = DateTime.now();
  late String _startDate, _endDate;
  final DateRangePickerController _controller = DateRangePickerController();
  @override
  void initState() {
    final DateTime today = DateTime.now();
    _startDate = DateFormat('yyyy-MM-dd').format(today).toString();
    _endDate = DateFormat('yyyy-MM-dd')
        .format(today.add(Duration(days: 3)))
        .toString();
    _controller.selectedRange = PickerDateRange(
      today,
      today.add(
        Duration(days: 3),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: SfDateRangePicker(
            controller: _controller,
            selectionMode: DateRangePickerSelectionMode.range,
            onSelectionChanged: selectionChanged,
            allowViewNavigation: false,
          ),
        )
      ],
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
      _endDate = DateFormat('yyyy-MM-dd')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
    Get.find<SearchRoomController>().changeToSelectedDate(_startDate, _endDate);
  }
}
