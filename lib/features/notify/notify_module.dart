import 'package:flutter_modular/flutter_modular.dart';
import './notify_controller.dart';
import './notify_page.dart';

class NotifyModule extends Module {
    @override
    final List<Bind> binds = [
      Bind.lazySingleton((i) => NotifyController()),
    ];
 
    @override
    final List<ModularRoute> routes = [
      ChildRoute('/', child: (_, args) => NotifyPage(controller: Modular.get())),
    ];
 
}