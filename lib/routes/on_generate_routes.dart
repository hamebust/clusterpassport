import 'package:cluster_passport/features/app/const/page_const.dart';
import 'package:cluster_passport/features/app/welcome/welcome_page.dart';
import 'package:cluster_passport/features/contacts/contacts_page.dart';
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

      case PageConst.welcomePage:
        {
            return materialPageBuilder(const WelcomePage());
        }


      // Página de configuración
      // Settings page
      //case PageConst.settingsPage:
      //  {
      //      return materialPageBuilder( SettingsPage());
      //  }

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



