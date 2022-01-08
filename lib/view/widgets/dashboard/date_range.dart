import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:samudra_bilash_hotel/controller/search_room_controller.dart';
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
    _controller.selectedRange =
        PickerDateRange(today, today.add(Duration(days: 3)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /*  Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 50,
            child: Text('StartRangeDate:' '$_startDate')),
        Container(height: 50, child: Text('EndRangeDate:' '$_endDate')), */
        Container(
          // height: 300,
          // color:Colors.yellow,
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
    /* Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Text('From',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context, 'from', fromSelectedDate);
                    },
                    child: Text(
                        "${fromSelectedDate.day}/${fromSelectedDate.month}/${fromSelectedDate.year}"),
                  ),
                  // Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text('To',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context, 'to', toSelectedDate);
                    },
                    child: Text(
                        "${toSelectedDate.day}/${toSelectedDate.month}/${toSelectedDate.year}"),
                  ),
                  // Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                ],
              ),
            ),
          ],
        ),
      ),
    ); */
  }

  /* _selectDate(BuildContext context, String from, DateTime date) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != date)
      setState(() {
        if (from == 'from') {
          fromSelectedDate = selected;
          Get.find<SearchroomController>().changeFromSelectedDate(selected);
        } else {
          toSelectedDate = selected;
          Get.find<SearchroomController>().changeToSelectedDate(selected);
        }
        // selectedDate = selected;
      });
  } */

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
      _endDate = DateFormat('yyyy-MM-dd')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
    Get.find<SearchroomController>().changeToSelectedDate(_startDate, _endDate);
    print(_startDate+'-'+_endDate);
  }
}
