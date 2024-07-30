//Paquete que permite conectar a dart:async para hacer un delay en la pantalla de presentación
//Package that allows connecting to dart:async to make a delay in the presentation screen
import 'dart:async';

//Paquete que permite conectar a hoja de estilos de la aplicación en la carpeta lib/features/app/theme/style
//Package that allows connecting to the style sheet of the application in the lib/features/app/theme/style folder
import 'package:cluster_passport/features/app/theme/style.dart';

//Paquete que permite conectar a WelcomePage: página de bienvenida en la carpeta lib/features/app/welcome
//Package that allows connecting to WelcomePage: welcome page in the lib/features/app/welcome folder
import 'package:cluster_passport/features/app/welcome/welcome_page.dart';

//Paquete que permite conectar a Flutter: widget principal de la aplicación en la carpeta main.dart
//Package that allows connecting to Flutter: main widget of the application in main.dart
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignorar: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

//Clase que contiene el estado del widget SplashScreen que permite un delay en la pantalla de presentación
//Class that contains the state of the SplashScreen widget that allows a delay in the presentation screen
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const WelcomePage(),
          ),
          (route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Image.asset(
              "assets/whats_app_logo.png",
              color: Colors.white,
              width: 100,
              height: 100,
            ),
            Column(
              children: [
                Text(
                  "from",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: greyColor.withOpacity(.6)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/meta.png",
                      color: Colors.white,
                      width: 35,
                      height: 35,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Meta",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            )
          ],
        ));
  }
}
