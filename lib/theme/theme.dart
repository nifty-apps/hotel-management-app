import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light().copyWith(
      secondary: Color(0xFF8661C1),
      primary: Colors.white,
      background: Color(0xFFF1F8FF),
    ),
    brightness: Brightness.light,
    highlightColor: Colors.white,
    hintColor: Color(0xFF9E9E9E),
    disabledColor: Color(0xFF343A40),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
