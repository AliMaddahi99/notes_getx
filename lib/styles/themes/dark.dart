import 'package:flutter/material.dart';
import 'package:notes_getx/styles/colors.dart';

ThemeData dark = ThemeData(
  // BRIGHTNESS
  brightness: Brightness.dark,

  // COLOR SCHEME
  colorScheme: ColorScheme.dark(
    secondary: darkPrimaryColor,
  ),

  // FONT FAMILY
  fontFamily: "Capriola",

  // APP BAR
  appBarTheme: AppBarTheme(
    backgroundColor: darkPrimaryColor,
    elevation: 0.0,
    iconTheme: const IconThemeData(color: Colors.black),
    foregroundColor: Colors.black,
  ),

  // SCAFFOLD
  scaffoldBackgroundColor: Colors.black,

  // CARD
  cardTheme: CardTheme(
    color: darkCard,
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),

  // CHECKBOX
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all<Color>(darkPrimaryColor),
  ),

  // TEXT BUTTON
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: darkPrimaryColor,
    ),
  ),

  // ELEVATED BUTTON
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkPrimaryColor,
      foregroundColor: Colors.black,
    ),
  ),

  // TEXTFIELD
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: darkPrimaryColor,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(16.0),
      ),
    ),
  ),

  // TEXT SELECTION THEME
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: darkPrimaryColor,
    selectionHandleColor: darkPrimaryColor,
    selectionColor: darkPrimaryColor,
  ),

  // FAB
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkPrimaryColor,
    foregroundColor: Colors.black,
    elevation: 0.0,
    highlightElevation: 0.0,
  ),
);
