import 'package:cluster_passport/features/app/theme/widgets_theme/app_text_theme.dart';
import 'package:flutter/material.dart';


class AppTheme{
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: AppTextTheme.lightTextTheme,
    
  );
  static ThemeData darkTheme  = ThemeData(
    brightness: Brightness.dark,
    textTheme: AppTextTheme.darkTextTheme
  );
}