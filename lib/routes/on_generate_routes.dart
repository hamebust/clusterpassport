//OnGenerateRoute: generador de rutas de la aplicación
//Route generator of the application

//Sección de Paquetes
//Packages section

  //Paquete que permite conectar a PageConst: constantes en la carpeta lib/features/app/const
  //Package that allows connecting to PageConst: page constants in the lib/features/app/const folder
  import 'package:cluster_passport/features/app/const/page_const.dart';
  
  //Paquete que permite conectar a SettingsPage: página de configuración en la carpeta lib/features/app/settings
  //Package that allows connecting to SettingsPage: settings page in the lib/features/app/settings folder
  import 'package:cluster_passport/features/app/settings/settings_page.dart';

  //Paquete que permite conectar a WelcomePage: página de bienvenida en la carpeta lib/features/app/welcome
  //Package that allows connecting to WelcomePage: welcome page in the lib/features/app/welcome folder
  import 'package:cluster_passport/features/app/welcome/welcome_page.dart';
import 'package:cluster_passport/features/authorized/ui/chat_authorized_page.dart';

  //Paquete que permite conectar a ContactsPage: página de contactos en la carpeta lib/features/contacts
  //Package that allows connecting to ContactsPage: contacts page in the lib/features/contacts folder
  import 'package:cluster_passport/features/contacts/contacts_page.dart';

  //Paquete que permite conectar a Flutter: widget principal de la aplicación en la carpeta main.dart
  //Package that allows connecting to Flutter: main widget of the application in main.dart
  import 'package:flutter/material.dart';

class OnGenerateRoute{

  Route<dynamic>? route(RouteSettings settings){
    // ignore: unused_local_variable
    final args = settings.arguments;
    final name = settings.name;

    switch(name){

      // Página de selección de contactos
      // Contact selection page
      case PageConst.contactUsersPage:
        {
            return materialPageBuilder(const ContactsPage());
        }
      // Página de bienvenida
      // Welcome page
      case PageConst.welcomePage:
        {
            return materialPageBuilder(const WelcomePage());
        }
      // Página de configuración
      // Settings page
      case PageConst.settingsPage:
        {
            return materialPageBuilder( const SettingsPage());
        }

      // Página de Clusters
      // Clusters page
      case PageConst.chatAuthorizedPage:
        {
            return materialPageBuilder( const ChatAuthorizedPage());
        }

      
      // Página de usuarios autorizados
      // Authorized users page
      //case PageConst.authorizedUsersPage:
      //  {
      //      return materialPageBuilder( AuthorizedPage());
      //  }

      // Página de Clusters
      // Clusters page
      //case PageConst.clustersPage:
      //  {
      //      return materialPageBuilder( ClustersPage());
      //  }
      
      

    }
    return null;

  }
  
  dynamic materialPageBuilder(Widget child){
    return MaterialPageRoute(builder: (context) => child);
  }
}



