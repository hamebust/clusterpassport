//NewsPage: Página de novedades en la carpeta lib/features/app/news
//NewsPage: news page in the lib/features/app/news folder

// Todas las notas son en español e inglés
// All notes are in spanish and english

//Sección de Paquetes
//Packages section
//Paquete que permite conectar a Flutter: widget principal de la aplicación en la carpeta main.dart
//Package that allows connecting to Flutter: main widget of the application in main.dart
import 'package:cluster_passport/features/app/global/date/date_formats.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:4197801718.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1493274669.
class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Estado de mis novedades
            //My news state
            Row(
              children: [
                Stack(
                  children: [
                    //Fotos de mis novedades
                    //My news photos
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset("assets/profile_default.png"),
                      ),
                    ),
                    //Botón de agregar novedad
                    //Add news button
                    Positioned(
                      right: 10,
                      bottom: 8,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: tabColor,
                            borderRadius: BorderRadius.circular(25),
                            border:
                                Border.all(width: 2, color: backgroundColor)),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: backgroundColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //Caja separadora
                //Separator box
                const SizedBox(
                  width: 10,
                ),

                //Texto de mis novedades
                //My news text
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Status",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Tap to add a new cluster",
                        style: TextStyle(color: greyColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //Caja separadora
            //Separator box
            const SizedBox(
              height: 10,
            ),

            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Recent news",
                style: TextStyle(
                    fontSize: 16,
                    color: greyColor,
                    fontWeight: FontWeight.bold),
              ),
            ),

            const Divider(
              color: greyColor,
              thickness: 1,
            ),

            //Caja separadora
            //Separator box
            const SizedBox(
              height: 10,
            ),

// Suggested code may be subject to a license. Learn more: ~LicenseLog:43133920.
            //constructor de lista de notificaciones
            //notification list constructor
            ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      margin: const EdgeInsets.all(3),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset("assets/profile_default.png"),
                      ),
                    ),
                    //Usuario
                    //User
                    title: const Text(
                      "User",
                      style: TextStyle(fontSize: 16),
                    ),
                    //Descripción
                    //Description
                    subtitle: Text(
                      formatDateTime(DateTime.now()),
                      style: const TextStyle(color: greyColor),
                    ),
                  );
                } ),
          ],
        ),
      ),
    );
  }
}
