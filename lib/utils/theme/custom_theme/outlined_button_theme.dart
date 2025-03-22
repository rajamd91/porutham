//
//
//
import 'package:flutter/material.dart';

// import '../../../constants/colors.dart';
// import '../../../constants/sizes.dart';

class TOutlineButtonTheme {
  TOutlineButtonTheme._(); // To avoid creating instances

  /// Light Theme
  static final OutlinedButtonThemeData lightOutlineButtonTheme =
      OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      textStyle: const TextStyle(
          fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
    ),
  );

  /// Dark Theme
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(color: Colors.blueAccent),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      textStyle: const TextStyle(
          fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
    ),
  );
}
