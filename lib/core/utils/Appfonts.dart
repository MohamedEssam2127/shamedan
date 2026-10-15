import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static String? get lemonada => GoogleFonts.lemonada().fontFamily;

  static String? get lalezar => GoogleFonts.lalezar().fontFamily;

  static String? get Cairo => GoogleFonts.cairo().fontFamily;
  static String? get arefRuqaa => GoogleFonts.arefRuqaa().fontFamily;
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
  static TextStyle titleLalezar = TextStyle(
    fontFamily: lalezar,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );

  static TextStyle regularArefRuqaa = TextStyle(
    fontFamily: arefRuqaa,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static TextStyle regularCairo = TextStyle(
    fontFamily: Cairo,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static TextStyle titleArefRuqaa = TextStyle(
    fontFamily: arefRuqaa,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );

  static TextStyle titleLemonada = TextStyle(
    fontFamily: lemonada,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );
}
