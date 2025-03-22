import 'package:flutter/material.dart';

// import '../../../constants/colors.dart';
// import '../../../constants/sizes.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TAppbarTheme {
  TAppbarTheme._();

  static const lightAppbarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: TColors.black, size: TSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
  );

  static const darkAppbarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24.0),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24.0),
    titleTextStyle: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
  );
}
