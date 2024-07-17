

import 'package:cluster_passport/features/app/const/page_const.dart';
import 'package:cluster_passport/features/app/home/contacts_page.dart';
import 'package:flutter/material.dart';

class OnGenerateRoute{

// Suggested code may be subject to a license. Learn more: ~LicenseLog:1518047103.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2100753167.
  static Route<dynamic>? route(RouteSettings settings){
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4238597660.
    final args = settings.arguments;
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4033119267.
    final name = settings.name;

// Suggested code may be subject to a license. Learn more: ~LicenseLog:1640905759.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:434045757.
    switch(name){
      case PageConst.contactUsersPage:
        {
            return materialPageBuilder(const ContactsPage());
        }

      case PageConst.settingsPage:
        {
            return materialPageBuilder( SettingsPage());
        }



    }
    return null;

    

  }
  
  dynamic materialPageBuilder(Widget child){
    return MaterialPageRoute(builder: (context) => child);
  }
}



