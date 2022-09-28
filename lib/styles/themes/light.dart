import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_getx/styles/colors.dart';

ThemeData light = ThemeData(
  // BRIGHTNESS
  brightness: Brightness.light,

  // COLOR SCHEME
  colorScheme: const ColorScheme.light(
    secondary: primaryColor,
  ),

  // TEXT THEME
  textTheme: GoogleFonts.capriolaTextTheme(),

  // APP BAR
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black),
    foregroundColor: Colors.black,
  ),

  // SCAFFOLD
  scaffoldBackgroundColor: Colors.grey.shade100,

  // CARD
  cardTheme: CardTheme(
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),

  // CHECKBOX
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all<Color>(primaryColor),
  ),

  // TEXT BUTTON
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
    ),
  ),

  // ELEVATED BUTTON
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.black,
    ),
  ),

  // TEXTFIELD
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(16.0),
      ),
    ),
  ),

  // TEXT SELECTION THEME
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: primaryColor,
    selectionHandleColor: primaryColor,
    selectionColor: primaryColor,
  ),

  // FAB
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: Colors.black,
    elevation: 0.0,
    highlightElevation: 0.0,
  ),
);
