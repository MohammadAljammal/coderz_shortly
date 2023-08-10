import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

String fontFamily = 'Poppins';

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),

  /// Hint Color
  hintColor: HexColor('#BFBFBF'),

  disabledColor: const Color(0xff9E9AA7),
  /// Primary Colors
  primaryColor: HexColor('#2ACFCF'),
  primaryColorLight: HexColor('#2ACFCF'),
  primaryColorDark: HexColor('#3B3054'),

  /// Text Theme
  textTheme: GoogleFonts.getTextTheme(fontFamily).copyWith(
    headlineMedium: GoogleFonts.getFont(fontFamily,
        color: Colors.black, fontSize: 34.0, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.getFont(fontFamily,
        color: Colors.black,
        fontSize: 17.0,
        fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.getFont(fontFamily,
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.bold),
    bodyMedium: GoogleFonts.getFont(fontFamily,
        color: Colors.black,
        fontSize: 17.0,
        fontWeight: FontWeight.w500),
    bodySmall: GoogleFonts.getFont(fontFamily,
        color: Colors.black54,
        fontSize: 17.0,
        fontWeight: FontWeight.w500),
    displayMedium: GoogleFonts.getFont(fontFamily,
        color: Colors.white,
        fontSize: 17.0,
        fontWeight: FontWeight.bold),
  ),

  /// Background Colors
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: HexColor('#F0F1F6'),

  /// Divider Theme
  dividerTheme: const DividerThemeData(
      color: Colors.black26,
      indent: 0.0,
      endIndent: 0.0,
      thickness: 1.0,
      space: 0.5),

  /// Error Color
  errorColor: HexColor('#F46262'),


  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: const Color.fromRGBO(247, 248, 251, 1),
    backgroundColor: HexColor('#2ACFCF'),
  ),
  primaryTextTheme: const TextTheme(
    bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
  ),
  bottomSheetTheme:
  const BottomSheetThemeData(backgroundColor: Colors.transparent),
  canvasColor: Colors.white,
  highlightColor: Colors.grey[100]!.withOpacity(0.4),
  splashColor: Colors.transparent,


  dividerColor: HexColor("#e6e6e6"),
  fontFamily: GoogleFonts.poppins().fontFamily,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(size: 24),
    unselectedIconTheme: IconThemeData(size: 24),
    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    selectedItemColor: Color(0xff0b8458),
    type: BottomNavigationBarType.fixed,
    enableFeedback: true,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
  iconTheme: IconThemeData(
    color: HexColor('#2ACFCF'),
    size: 24,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: const Color(0xffFAFAFA),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    shadowColor: Colors.grey[200]!.withOpacity(.5),
    elevation: 1,
    iconTheme: const IconThemeData(
      color: Color.fromRGBO(51, 51, 51, 1),
      size: 24,
    ),
    actionsIconTheme: const IconThemeData(
      color: Color.fromRGBO(51, 51, 51, 1),
      size: 24,
    ),
  ),
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: HexColor('#2ACFCF'),
    secondary: const Color.fromRGBO(51, 51, 51, 1),
  ),
);
