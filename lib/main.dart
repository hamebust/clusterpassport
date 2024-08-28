// ClusterPasport. Aplicación de gestión de ingresos de personas a Instalaciones
// ClusterPassport. Application of person ingress management to Installations

// Todos los notas son en español e inglés
// All notes are in spanish and english

import 'package:cluster_passport/features/app/theme/app_theme.dart';
import 'package:cluster_passport/generated/l10n.dart';
import 'package:cluster_passport/routes/on_generate_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'main_injection_container.dart' as di;
import 'dart:async';

void main() async {
  // Asegura que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Manejo de errores global
  runZonedGuarded(() async {
    await di.init();
    // Ejecución de la aplicación Cluster Passport
    // Execution of Cluster Passport application
    runApp(const ClusterPassport());
  }, (error, stackTrace) {
    // Aquí puedes manejar los errores no capturados
    // Here you can handle uncaught errors
    print('Error no capturado: $error');
  });
}

// Clase principal de la aplicación
// Main application class
class ClusterPassport extends StatelessWidget {
  const ClusterPassport({super.key});

  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  // Método separado para construir el MaterialApp
  // Separate method to build the MaterialApp
  MaterialApp buildMaterialApp() {
    return MaterialApp(
      title: 'Cluster Passport',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('es'),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: "/",
      onGenerateRoute: OnGenerateRoute().route,
    );
  }
}