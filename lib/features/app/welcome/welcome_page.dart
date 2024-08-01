//WelcomePAge: página de bienvenida de la aplicación en la carpeta lib/features/app/welcome
//WelcomePage: welcome page of the application in the lib/features/app/welcome folder

  //Paquete que permite conectar a S: internacionalización de la aplicación en la carpeta lib/generated/l10n
  //Package that allows connecting to S: internationalization of the application in the lib/generated/l10n folder
  import 'package:cluster_passport/generated/l10n.dart';

  //Paquete que permite conectar a Flutter: widget principal de la aplicación en la carpeta main.dart
  //Package that allows connecting to Flutter: main widget of the application in main.dart
  import 'package:flutter/material.dart';

  //Paquete que permite conectar a la hoja de estilos de la aplicación en la carpeta lib/features/app/theme/style
  //Package that allows connecting to the style sheet of the application in the lib/features/app/theme/style folder
  import 'package:cluster_passport/features/app/theme/style.dart';

  //Paquete que permite conectar a LoginPage: página de inicio de sesión en la carpeta lib/features/user/presentation/pages
  //Package that allows connecting to LoginPage: login page in the lib/features/user/presentation/pages folder
  import 'package:cluster_passport/features/user/presentation/pages/login_page.dart';

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
            //Texto de bienvenida e imagen de fondo
            //Welcome text and background image
            Center(child: Text(
              //Paquete l10n -> S.of(context).WtoCP, contiene el texto de bienvenida
              //Package l10n -> S.of(context).WtoCP contains the welcome text
              S.of(context).WtoCP, 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tabColor),),),
            Image.asset("assets/bg_image.png"),
            Column(
              children: [
                //Texto de instrucciones sobre las politicas de privacidad
                //Instructions text about privacy policies
                Text(
                  //Paquete l10n -> S.of(context).ROPP contiene el texto de instrucciones de privacidad
                  //Package l10n -> S.of(context).ROPP contains the privacy policy instructions text
                  S.of(context).ROPP,
                  textAlign: TextAlign.center,style: const TextStyle(fontSize: 15),),
                
                //Caja separadora
                //Separator box
                const SizedBox(height: 30,),
                
                //Botón de aceptar
                //Accept button
                GestureDetector(
                  onTap: () {
                    //Navegación a la página de inicio de sesión
                    //Navigation to the login page
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginPage()));
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
                        //Paquete l10n -> S.of(context).AC contiene el texto de aceptar
                        //Package l10n -> S.of(context).AC contains the accept text
                        S.of(context).AC, 
                        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

