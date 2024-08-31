// ClusterPasport. Aplicación de gestión de ingresos de personas a Instalaciones
// ClusterPassport. Application of person ingress management to Installations

// Todos los notas son en español e inglés
// All notes are in spanish and english

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

void main() async {
  // Asegura que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase y dependencias antes de entrar en runZonedGuarded
  await initializeFirebase();
  await initializeDependencies();

  // Manejo de errores global
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    print('Error de plataforma no capturado: $error');
    return true;
  };

  // Ejecución de la aplicación Cluster Passport en una zona segura
  runZonedGuarded(() {
    runApp(const ClusterPassport());
  }, (error, stackTrace) {
    // Aquí puedes manejar los errores no capturados
    // Here you can handle uncaught errors
    print('Error no capturado: $error');
  });
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> initializeDependencies() async {
  await di.init();
}

// Clase principal de la aplicación
// Main application class
class ClusterPassport extends StatelessWidget {
  const ClusterPassport({super.key});

  @override
  Widget build(BuildContext context) {
    // Método separado para construir el MaterialApp
    // Separate method to build the MaterialApp
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
        locale: const Locale('es'),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: "/",
        onGenerateRoute: OnGenerateRoute().route,
      ),
    );
  }
}
