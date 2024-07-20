//import 'package:flutter_modular/flutter_modular.dart';
//import './contacts_controller.dart';
//import './contacts_page.dart';
//
//class ContactsModule extends Module {
//    @override
//    final List<Bind> binds = [
//      Bind.lazySingleton((i) => ContactsController()),
//    ];
// 
//    @override
//    final List<ModularRoute> routes = [
//      ChildRoute('/', child: (_, args) => ContactsPage(controller: Modular.get())),
//    ];
// 
//}