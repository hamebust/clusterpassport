//SettingsPage: página de configuración en la carpeta lib/features/app/settings
//SettingsPage: settings page in the lib/features/app/settings folder

// Todas las notas son en español e inglés
// All notes are in spanish and english

//Sección de Paquetes
//Packages section

  //Paquete que permite conectar a Flutter: widget principal de la aplicación en la carpeta main.dart
  //Package that allows connecting to Flutter: main widget of the application in main.dart
  import 'package:flutter/material.dart';
  //Paquete que permite conectar a Style: estilo de la aplicación en la carpeta lib/features/app/theme/style
  //Package that allows connecting to Style: style of the application in the lib/features/app/theme/style folder
  import 'package:cluster_passport/features/app/theme/style.dart';
  

// Suggested code may be subject to a license. Learn more: ~LicenseLog:2850830417.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1522323193.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de navegación superior
      // Navigation bar
      appBar: AppBar(
        // Título de la página
        // Page title
        title: const Text('Settings'),
      ),
      body: Column(
        // Widget Padre que contiene los datos del usuario que inicio sesión
        // Parent widget that contains the user data that logged in
        children: [
          // Widget hijo que contiene la foto de perfil del usuario y el nombre de usuario
          // Child widget that contains the user profile picture and username
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              // Widget hijo que contiene la foto de perfil del usuario
              // Child widget that contains the user profile picture
              children: [
                SizedBox(
                  width:65, 
                  height:65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.5),
                    child: Image.asset("assets/images/profile_default.png")
                  ),
                ),
            
                //Caja separadora
                //Separator box
                const SizedBox(width: 10,),
            
                // Widget hijo que contiene el nombre de usuario y el código de seguridad
                // Child widget that contains the username and security code
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username", style: TextStyle(fontSize: 18),),
                      Text("while true code{}", style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Caja separadora
          // Separator box
          const SizedBox(height: 2,),

          Container(
            width: double.infinity,
            height: 0.5,
            color: greyColor.withOpacity(.4),
          ),

          // Caja separadora
          // Separator box
          const SizedBox(height: 10,),

          //Area de configuraciones de la app
          //App configuration area

          //Cuenta
          
          _settingsItemWidget(
            title: "Account",
            description: "Security applications, change number",
            icon: Icons.key,
            onTap: () {},
          ),
          _settingsItemWidget(
              title: "Privacy",
              description: "Block contacts, disappearing messages",
              icon: Icons.lock,
              onTap: () {}
          ),
          _settingsItemWidget(
              title: "Chats",
              description: "Theme, wallpapers, chat history",
              icon: Icons.message,
              onTap: () {}
          ),
          _settingsItemWidget(
              title: "Logout",
              description: "Logout from WhatsApp Clone",
              icon: Icons.exit_to_app,
              onTap: () {}
          ),
          
        ],
      )
    );
  }


  _settingsItemWidget({String? title, String? description, IconData? icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(width: 80, height: 80, child: Icon(icon, color: greyColor, size: 25,)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$title", style: const TextStyle(fontSize: 17),),
                const SizedBox(height: 3,),
                Text("$description", style: const TextStyle(color: greyColor),)
              ],
            ),
          )
        ],
      ),
    );
  }

}
