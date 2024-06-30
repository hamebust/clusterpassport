// Todos los notas son en español e inglés
// All notes are in spanish and english

import 'package:cluster_passport/features/app/splash/splash_screen.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:cluster_passport/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


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
      //Localization      
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('es'),

      //Tema de la aplicación
      //App theme
      debugShowCheckedModeBanner: false,
      
        theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.green),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.system,
      

      //Página de inicio
      //Splash screen
      home: const SplashScreen(),
    );

  }
}
