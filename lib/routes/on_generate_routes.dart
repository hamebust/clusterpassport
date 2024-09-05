//OnGenerateRoute: generador de rutas de la aplicación
//Route generator of the application

//Sección de Paquetes
//Packages section

import 'package:cluster_passport/features/app/const/page_const.dart';
import 'package:cluster_passport/features/app/settings/settings_page.dart';
import 'package:cluster_passport/features/app/welcome/welcome_page.dart';
import 'package:cluster_passport/features/authorized/presentation/pages/authorized/authorized_page.dart';
import 'package:cluster_passport/features/authorized/presentation/pages/chat/chat_authorized_page.dart';
import 'package:cluster_passport/features/user/presentation/pages/contacts_page.dart';
import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:cluster_passport/features/user/presentation/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';

class OnGenerateRoute {
  Route<dynamic>? route(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;
    final name = settings.name;

    switch (name) {
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
          if (args is String) {
            return materialPageBuilder(SettingsPage(uid: args));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }
      // Página de configuración
      // Settings page
      case PageConst.editProfilePage:
        {
          if (args is UserEntity) {
            return materialPageBuilder(EditProfilePage(currentUser: args,));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }

      // Página de Clusters
      // Clusters page
      case PageConst.chatAuthorizedPage:
        {
          return materialPageBuilder(const ChatAuthorizedPage());
        }

      // Página de usuarios autorizados
      // Authorized users page
      case PageConst.authorizedUsersPage:
        {
          return materialPageBuilder( AuthorizedPage());
        }

      // Página de Clusters
      // Clusters page
      //case PageConst.clustersPage:
      //  {
      //      return materialPageBuilder( ClustersPage());
      //  }
    }
    return null;
  }

  dynamic materialPageBuilder(Widget child) {
    return MaterialPageRoute(builder: (context) => child);
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Error"),
      ),
    );
  }
}