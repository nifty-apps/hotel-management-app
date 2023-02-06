import 'package:flutter/material.dart';

 showSnackBarMethod(BuildContext context, String message,bool isSuccess) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor:isSuccess? Colors.green: Theme.of(context).errorColor,
    ),
  );
}
