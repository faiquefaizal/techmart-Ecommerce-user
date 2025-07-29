import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(focusColor: Colors.black),
  // primarySwatch: MaterialColor(, swatch),
  focusColor: Colors.black,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.black,
    splashColor: Colors.grey.shade100,
    textTheme: ButtonTextTheme.normal,
  ),
  appBarTheme: AppBarTheme(centerTitle: true, backgroundColor: Colors.white),
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  navigationBarTheme: NavigationBarThemeData(backgroundColor: Colors.black),
  cardColor: Colors.white,
  shadowColor: Colors.black.withAlpha((0.2 * 0.255).toInt()),
  textTheme: TextTheme(
    labelSmall: TextStyle(fontFamily: "GeneralSans", fontSize: 20),
    labelMedium: TextStyle(fontFamily: "GeneralSans", fontSize: 15),
    labelLarge: TextStyle(fontFamily: "GeneralSans", fontSize: 15),
    titleMedium: GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.w900,
      height: 1,
    ),
    displayLarge: GoogleFonts.lato(
      fontSize: 60,
      fontWeight: FontWeight.w900,
      height: 1,
    ),
    displaySmall: GoogleFonts.lato(
      fontSize: 45,
      fontWeight: FontWeight.w900,
      height: 1,
    ),
    displayMedium: GoogleFonts.lato(
      fontSize: 35,
      fontWeight: FontWeight.w900,
      height: 1,
    ),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
    headlineLarge: GoogleFonts.lato(
      fontSize: 25,
      fontWeight: FontWeight.w900,
      height: 1,
    ),

    headlineSmall: GoogleFonts.lato(
      fontSize: 18,
      fontWeight: FontWeight.w900,
      height: 1,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.grey;
        }
        return Colors.black; // Default color
      }),
    ),
  ),
);
