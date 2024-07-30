//ClusterPasport. Aplicación de gestión de ingresos de personas a Instalaciones
//ClusterPassport. Application of person ingress management to Installations

// Todos los notas son en español e inglés
// All notes are in spanish and english

//Paquete que permite conectar a SplashScreen: vista de presentación de la aplicación en la carpeta lib/features/app/splash
//Package that allows connecting to SplashScreen: presentation of the application in the lib/features/app/splash folder
import 'package:cluster_passport/features/app/splash/splash_screen.dart';

//Paquete que permite conectar a Theme: tema de la aplicación en la carpeta lib/features/app/theme
//Package that allows connecting to Theme: theme of the application in the lib/features/app/theme folder
import 'package:cluster_passport/features/app/theme/app_theme.dart';

//Paquete que permite conectar a S: internacionalización de la aplicación en la carpeta lib/generated/l10n
//Package that allows connecting to S: internationalization of the application in the lib/generated/l10n folder
import 'package:cluster_passport/generated/l10n.dart';

//Paquete que permite conectar a OnGenerateRoute: generador de rutas de la aplicación en la carpeta routes/on_generate_routes
//Package that allows connecting to OnGenerateRoute: route generator of the application in the routes/on_generate_routes folder
import 'package:cluster_passport/routes/on_generate_routes.dart';

//Paquete que permite conectar a MaterialApp: widget principal de la aplicación en la carpeta main.dart
//Package that allows connecting to MaterialApp: main widget of the application in main.dart
import 'package:flutter/material.dart';

//Paquete que permite conectar a FlutterLocalization: internacionalización de Flutter en la carpeta flutter_localizations
//Package that allows connecting to FlutterLocalization: internationalization of Flutter in the flutter_localizations folder
import 'package:flutter_localizations/flutter_localizations.dart';

//import 'package:flutter_modular/flutter_modular.dart';
//import 'package:cluster_passport/app_modular/app_modular.dart';

void main() {
  //Ejecución de la aplicación Cluster Passport
  //Execution of Cluster Passport application
  runApp(const ClusterPassport());
//  runApp(ModularApp(module: AppModule(), child: const ClusterPassport()));
}

// Clase principal de la aplicación
// Main application class
// Clase ClusterPassport que extiende un widget sin estado
// ClusterPassport class that extends a StatelessWidget without state
class ClusterPassport extends StatelessWidget {
  const ClusterPassport({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //Titulo de la aplicación
        //App title
        title: 'Cluster Passport',

        //Paquete de internacionalización de Flutter localización
        //Flutter localization package
        localizationsDelegates: const [
          //La clase S que se encuentra en el archivo l10n.dart
          //The S class that is found in l10n.dart
          //Los archivos de traducción se encuentran en la carpeta lib/l10n
          //The translation files are found in the lib/l10n folder
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,

        //Idioma de la aplicación:  esta sección configura el lenguaje en el que se muestra la app
        //App language: this section configures the language in which the app is displayed
        //Idioma actual Español
        //Current language Spanish
        locale: const Locale('es'),

        //Tema de la aplicación
        //App theme
        debugShowCheckedModeBanner: false,
        //Tema claro: esta sección configura el tema claro de la app
        //This section configures the light theme of the app
        theme: AppTheme.lightTheme,
        //Tema oscuro: esta sección configura el tema oscuro de la app
        //This section configures the dark theme of the app
        darkTheme: AppTheme.darkTheme,
        //Modo de tema: esta sección configura el modo de tema de la app
        //This section configures the theme mode of the app
        themeMode: ThemeMode.system,

        //Rutas de la aplicación
        //App routes
        //Ruta inicial: esta sección configura la ruta inicial de la app
        //This section configures the initial route of the app
        initialRoute: "/",
        //Generador de rutas: esta sección configura el generador de rutas de la app
        //This section configures the route generator of the app
        onGenerateRoute: OnGenerateRoute().route,
        //Rutas: esta sección configura las rutas de la app
        //This section configures the routes of the app
        routes: {
          '/': (context) => const SplashScreen(),
        });
  }
}
