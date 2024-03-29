import 'package:flutter/material.dart';

showSnackBarMethod(BuildContext context, String message, bool isSuccess) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor:
          isSuccess ? Colors.green : Theme.of(context).colorScheme.error,
    ),
  );
}

Future<DateTime?> selectDate(BuildContext context) async {
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2023),
    lastDate: DateTime(2030),
    builder: (context, child) => Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: child!,
    ),
  );

  DateTime? startOfDay = pickedDate != null
      ? DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 12)
      : null;

  return startOfDay;
}
