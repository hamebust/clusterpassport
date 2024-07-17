//import 'package:flutter_modular/flutter_modular.dart';
//import './authorized_controller.dart';
//import './authorized_page.dart';
//
//class AuthorizedModule extends Module {
//    @override
//    final List<Bind> binds = [
//      Bind.lazySingleton((i) => AuthorizedController()),
//    ];
// 
//    @override
//    final List<ModularRoute> routes = [
//      ChildRoute('/', child: (_, args) => AuthorizedPage(controller: Modular.get())),
//    ];
// 
//}