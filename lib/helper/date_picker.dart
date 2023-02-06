import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String?> selectDate(BuildContext context) async {
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2023),
    lastDate: DateTime(2030),
    builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: Theme.of(context).colorScheme.secondary)),
        child: child!),
  );
  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
  return formattedDate;
}
