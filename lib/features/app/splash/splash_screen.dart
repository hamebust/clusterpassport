// SplashScreen: página de Bienvenida a la aplicación
// SplashScreen: Welcome page of the application

// Todas las notas son en español e inglés
// All notes are in Spanish and English

// Sección de Paquetes
// Packages section
import 'dart:async';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:cluster_passport/features/app/welcome/welcome_page.dart';
import 'package:flutter/material.dart';

/// SplashScreen: Muestra una pantalla de bienvenida con un logo y un mensaje breve antes de navegar a la página de inicio.
/// SplashScreen: Displays a welcome screen with a logo and a brief message before navigating to the home page.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcomePage();
  }

  /// Navega a la página de bienvenida después de un retraso de 2 segundos.
  /// Navigates to the welcome page after a 2-second delay.
  void _navigateToWelcomePage() {
    Timer(const Duration(seconds: 2), () {
      // Verifica si el widget aún está montado antes de navegar.
      // Check if the widget is still mounted before navigating.
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const WelcomePage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Color de fondo de la pantalla de bienvenida
      // Background color of the splash screen
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Elemento de relleno para centrar el logo verticalmente
          // Filler element to center the logo vertically
          Container(),
          
          // Logo de la aplicación
          // App logo
          Image.asset(
            "assets/whats_app_logo.png",
            color: Colors.white,
            width: 100,
            height: 100,
          ),

          // Sección inferior con información adicional
          // Bottom section with additional information
          Column(
            children: [
              // Texto "from"
              Text(
                "from",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: greyColor.withOpacity(.6),
                ),
              ),
              const SizedBox(height: 10),

              // Logo de Meta y texto
              // Meta logo and text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/meta.png",
                    color: Colors.white,
                    width: 35,
                    height: 35,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Meta",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
