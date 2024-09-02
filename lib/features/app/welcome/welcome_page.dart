// WelcomePage: página de bienvenida de la aplicación en la carpeta lib/features/app/welcome
// WelcomePage: welcome page of the application in the lib/features/app/welcome folder

// Todas las notas son en español e inglés
// All notes are in Spanish and English

// Sección de Paquetes
// Packages section
import 'package:cluster_passport/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:cluster_passport/features/user/presentation/pages/login_page.dart';

/// WelcomePage: Muestra la pantalla de bienvenida de la aplicación con un mensaje y opciones de navegación.
/// WelcomePage: Displays the welcome screen of the application with a message and navigation options.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Texto de bienvenida centrado
            // Centered welcome text
            Center(
              child: Text(
                // Paquete l10n -> S.of(context).WtoCP contiene el texto de bienvenida
                // Package l10n -> S.of(context).WtoCP contains the welcome text
                S.of(context).WtoCP,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: tabColor,
                ),
              ),
            ),

            // Imagen de fondo con tamaño limitado
            // Background image with limited size
            Container(
              constraints: const BoxConstraints(
                minWidth: 50,
                minHeight: 50,
                maxWidth: 350,
                maxHeight: 350,
              ),
              child: Image.asset(
                "assets/bg_image.png",
                fit: BoxFit.contain,
              ),
            ),

            // Sección inferior con instrucciones y botón de aceptar
            // Bottom section with instructions and accept button
            Column(
              children: [
                // Texto de instrucciones sobre las políticas de privacidad
                // Instructions text about privacy policies
                Text(
                  // Paquete l10n -> S.of(context).ROPP contiene el texto de instrucciones de privacidad
                  // Package l10n -> S.of(context).ROPP contains the privacy policy instructions text
                  S.of(context).ROPP,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),

                // Caja separadora
                // Separator box
                const SizedBox(height: 30),

                // Botón de aceptar
                // Accept button
                GestureDetector(
                  onTap: () {
                    // Navegación a la página de inicio de sesión
                    // Navigation to the login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tabColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        // Paquete l10n -> S.of(context).AC contiene el texto de aceptar
                        // Package l10n -> S.of(context).AC contains the accept text
                        S.of(context).AC,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
