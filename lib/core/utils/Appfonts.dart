import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static String? get lemonada => GoogleFonts.lemonada().fontFamily;
  static String? get lalezar => GoogleFonts.lalezar().fontFamily ;
  static TextStyle regularLemonade = TextStyle(
    fontFamily: lemonada,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static TextStyle regularLalezar = TextStyle(
    fontFamily: lalezar,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
}
