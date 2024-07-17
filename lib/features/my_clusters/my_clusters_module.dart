import 'package:flutter_modular/flutter_modular.dart';
import './my_clusters_controller.dart';
import './my_clusters_page.dart';

class MyClustersModule extends Module {
    @override
    final List<Bind> binds = [
      Bind.lazySingleton((i) => MyClustersController()),
    ];
 
    @override
    final List<ModularRoute> routes = [
      ChildRoute('/', child: (_, args) => MyClustersPage(controller: Modular.get())),
    ];
 
}