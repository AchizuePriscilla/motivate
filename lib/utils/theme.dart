import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primary = Color(0XFF2C54D8);

const Color accent = Color(0XFF7289DA);

const Color white = Colors.white;

const Color black = Colors.black;

const Color grey = Colors.grey;

const Color textAltColor = Color(0xFFAFB2FF);

const Color deepPurple = Color(0xFF8645D8);

const Color deepPink = Color(0xFFD20568);

const Color dividerColor = Color(0xff40306C);

const Color bgColor = Color(0xff0C0326);

themeData(context) => ThemeData(
      textTheme: GoogleFonts.manropeTextTheme(Theme.of(context).textTheme),
      primarySwatch: Colors.blue,
      primaryColor: bgColor,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );


