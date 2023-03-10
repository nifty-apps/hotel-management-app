import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFF3F3F3),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 22),
      iconTheme: IconThemeData(
        color: Color(0xFF113F67),
      ),
    ),
    colorScheme: ColorScheme.light().copyWith(
      secondary: Color(0xFF113F67),
      primary: Color(0xFF0059AA),
      background: Color(0xFFF3F3F3),
      primaryContainer: Color(0xFFFFFFFF),
    ),
    brightness: Brightness.light,
    highlightColor: Colors.white,
    hintColor: Color(0xFF9E9E9E),
    disabledColor: Color(0xFF343A40),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
