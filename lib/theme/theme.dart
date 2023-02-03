import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFE7EAF6),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFE7EAF6),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Color(0xFF113F67),
      ),
    ),
    colorScheme: ColorScheme.light().copyWith(
      secondary: Color(0xFF113F67),
      primary: Color(0xFFA2A8D3),
      background: Color(0xFFE7EAF6),
    ),
    brightness: Brightness.light,
    highlightColor: Colors.white,
    hintColor: Color(0xFF9E9E9E),
    disabledColor: Color(0xFF343A40),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
