import 'package:cluster_passport/features/app/home/widgets_home/icon_appbar_home_page.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:cluster_passport/features/authorized/authorized_page.dart';
import 'package:cluster_passport/features/clusters/clusters_page.dart';
import 'package:cluster_passport/features/my_clusters/my_clusters_page.dart';
import 'package:cluster_passport/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de navegación
      // Navigation bar
      appBar: AppBar(
        // boton de retroceso desactivado
        // Back button disabled
        automaticallyImplyLeading: false,

        // Título de la aplicación
        // App title
        title: Text(
          S.of(context).Passport0,
          style: Theme.of(context).textTheme.titleLarge,
        ),

        // Botones de la barra de navegación superior
        // Navigation superior bar buttons
        actions: [
          Row(
            children: [
              // Botón de filtro
              // Filter button
              iconAppBarHomePage(
                icon: Icons.filter_list,
                color: greyColor,
                size: 28,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('Contenido de la BottomSheet'),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(
                width: 20,
              ),

              // Botón de búsqueda
              // Search button
              iconAppBarHomePage(
                  icon: Icons.search,
                  color: greyColor,
                  size: 28,
                  onPressed: () {}),

              const SizedBox(
                width: 20,
              ),

              // Botón de menú
              // Menu button
              iconAppBarHomePage(
                icon: Icons.more_vert,
                color: greyColor,
                size: 28,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        // Usa SizedBox en lugar de ListView
                        height: 200,
                        child: Column(
                          // Usa Column para organizar los elementos verticalmente
                          children: <Widget>[
                            ListTile(
                              // Usa ListTile para cada ítem
                              leading: const Icon(Icons.settings),
                              title: const Text('Configuración'),
                              onTap: () {
                                // Acción al presionar "Configuración"
                                Navigator.pop(context); // Cierra el BottomSheet
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.info),
                              title: const Text('Acerca de'),
                              onTap: () {
                                // Acción al presionar "Acerca de"
                                Navigator.pop(context);
                              },
                            ),
                            // Agrega más ListTile según sea necesario
                          ],
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),

      // Cuerpo de la aplicación
      // App body
      body: <Widget>[
        // Página de Autorizados
        // Authorized page
        const AuthorizedPage(),

        // Página de autorizaciones
        // Authorized page
        const MyClustersPage(),

        // Página de notificaciones
        // Notifications page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Hello',
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'Hi!',
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],

      // Botón flotante
      // Floating button
      floatingActionButton:
          switchFloatingActionButtonOnPageIndex(currentPageIndex),
      //
      // Barra de navegación inferior
      // Bottom navigation bar
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.grey,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          //Botón Página de autorizados
          //Authorized page button
          NavigationDestination(
            selectedIcon: Icon(Icons.sensor_occupied),
            icon: Icon(Icons.groups),
            label: 'Autorized',
          ),

          //Botón Página de clusters
          //Clusters page button
          NavigationDestination(
            icon: Badge(child: Icon(Icons.location_city)),
            label: 'Cluster',
          ),

          //Botón Página de notificaciones
          //Notifications page button
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Notify',
          ),
        ],
      ),
    );
  }

  // Estado del boton flotante
  // Floating button state
  switchFloatingActionButtonOnPageIndex(currentPageIndex) {
    switch (currentPageIndex) {
      // Boton de agregar usuario
      // Add user button
      case 0:
        return FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.person_add),
        );

      // Boton de agregar cluster
      // Add cluster button
      case 1:
        return FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClustersPage()),
            );
          },
          child: const Icon(Icons.add_card),
        );

      //case 2:
      //return FloatingActionButton(
      //onPressed: () {},
      //child: const Icon(Icons.add),
      //);
    }
  }

  Widget iconAppBarHomePage(
      {required IconData icon,
      required Color color,
      double size = 24,
      required VoidCallback onPressed}) {
    return IconAppBarHomePage(
        icon: icon, color: color, size: size, onPressed: onPressed);
  }
}
