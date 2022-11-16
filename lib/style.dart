import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const brightness = Brightness.light;

ThemeData androidTheme() {
  return ThemeData(
    brightness: brightness,
    textTheme: TextTheme(
      bodyText2: GoogleFonts.quicksand(),
      bodyText1: GoogleFonts.quicksand(),
      button: GoogleFonts.quicksand(),
      caption: GoogleFonts.quicksand(),
      headline4: GoogleFonts.quicksand(),
      headline3: GoogleFonts.quicksand(),
      headline2: GoogleFonts.quicksand(),
      headline1: GoogleFonts.quicksand(),
      headline5: GoogleFonts.quicksand(),
      overline: GoogleFonts.quicksand(),
      subtitle1: GoogleFonts.quicksand(),
      subtitle2: GoogleFonts.quicksand(),
      headline6: GoogleFonts.quicksand(),
    ),
    primaryColor: const Color.fromRGBO(19, 124, 65, 1),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color.fromRGBO(42, 44, 43, 1),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: GoogleFonts.quicksand(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color.fromRGBO(19, 124, 65, 1),
      textTheme: ButtonTextTheme.primary,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: const Color.fromRGBO(19, 124, 65, 1),
      textStyle: GoogleFonts.quicksand(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
  );
}
