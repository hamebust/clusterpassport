// ClusterPassport: Aplicación de gestión de ingresos de personas a instalaciones
// ClusterPassport: Application for managing person ingress to installations

// Importación de paquetes necesarios
// Import necessary packages
import 'package:cluster_passport/features/app/theme/app_theme.dart';
import 'package:cluster_passport/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubit/get_device_number/get_device_number_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:cluster_passport/firebase_options.dart';
import 'package:cluster_passport/generated/l10n.dart';
import 'package:cluster_passport/routes/on_generate_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'main_injection_container.dart' as di;
import 'dart:async';

Future<void> main() async {
  // Asegura que los bindings de Flutter estén inicializados
  // Ensure that Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase y dependencias antes de entrar en runZonedGuarded
  // Initialize Firebase and dependencies before entering runZonedGuarded
  await initializeFirebase();
  await initializeDependencies();

  // Manejo de errores global para Flutter
  // Global error handling for Flutter
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  // Manejo de errores global para la plataforma
  // Global error handling for the platform
  PlatformDispatcher.instance.onError = (error, stack) {
    print('Error de plataforma no capturado: $error');
    return true;
  };

  // Ejecución de la aplicación Cluster Passport en una zona segura
  // Run the Cluster Passport application in a guarded zone
  runZonedGuarded(() {
    runApp(const ClusterPassport());
  }, (error, stackTrace) {
    // Aquí puedes manejar los errores no capturados
    // Handle uncaught errors here
    print('Error no capturado: $error');
  });
}

// Inicializa Firebase con las opciones de la plataforma actual
// Initialize Firebase with the current platform's options
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// Inicializa las dependencias del proyecto usando un contenedor de inyección de dependencias
// Initialize project dependencies using a dependency injection container
Future<void> initializeDependencies() async {
  await di.init();
}

// Clase principal de la aplicación
// Main application class
class ClusterPassport extends StatelessWidget {
  const ClusterPassport({super.key});

  @override
  Widget build(BuildContext context) {
    // Construye el MaterialApp y proporciona los Cubits necesarios usando MultiBlocProvider
    // Build the MaterialApp and provide the necessary Cubits using MultiBlocProvider
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider(
          create: (context) => di.sl<CredentialCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetDeviceNumberCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Cluster Passport',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('es'),  // Fija el idioma a español
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,  // Tema claro
        darkTheme: AppTheme.darkTheme,  // Tema oscuro
        themeMode: ThemeMode.system,  // Cambia entre temas automáticamente según el sistema
        initialRoute: "/",  // Ruta inicial de la aplicación
        onGenerateRoute: OnGenerateRoute().route,  // Genera rutas dinámicas
      ),
    );
  }
}
