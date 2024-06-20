// Todos los notas son en español e inglés
// All notes are in spanish and english

import 'package:cluster_passport/features/app/splash/splash_screen.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const ClusterPassport());
}


class ClusterPassport extends StatelessWidget {
  const ClusterPassport({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cluster Passport',

      //Flutter localización
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        dialogBackgroundColor: appBarColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor,
        ),
      ),
      home: const SplashScreen(),
    );

  }
}
