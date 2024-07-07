import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2764342932.
  static TextTheme lightTextTheme = const TextTheme(
    headlineMedium: TextStyle(
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      color: greyColor,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
    headlineMedium: TextStyle(
      color: Colors.white70,
    ),
    bodyLarge: TextStyle(
      color: Colors.white60,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      color: whiteColor,
      fontWeight: FontWeight.w600,
    ),
  );
}
