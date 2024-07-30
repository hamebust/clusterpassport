//HomePage: página principal de la aplicación en la carpeta lib/features/app/home
//HomePage: main page of the application in the lib/features/app/home folder

//Sección de Paquetes
//Packages section

  //Paquete que permite conectar a PageConst: constantes en la carpeta lib/features/app/const
  //Package that allows connecting to PageConst: page constants in the lib/features/app/const folder
  import 'package:cluster_passport/features/app/const/page_const.dart';
  //Paquete que permite conectar a IconAppBarHomePage: icono de la barra de navegación en la carpeta lib/features/app/home/widgets_home
  //Package that allows connecting to IconAppBarHomePage: icon of the navigation bar in the lib/features/app/home/widgets_home folder
  import 'package:cluster_passport/features/app/home/widgets_home/icon_appbar_home_page.dart';
  //Paquete que permite conectar a Style: estilo de la aplicación en la carpeta lib/features/app/theme/style
  //Package that allows connecting to Style: style of the application in the lib/features/app/theme/style folder
  import 'package:cluster_passport/features/app/theme/style.dart';
  //Paquete que permite conectar a AuthorizedPage: página de autorizados en la carpeta lib/features/authorized
  //Package that allows connecting to AuthorizedPage: authorized page in the lib/features/authorized folder
  import 'package:cluster_passport/features/authorized/authorized_page.dart';
  //Paquete que permite conectar a ClustersPage: página de clusters en la carpeta lib/features/clusters
  //Package that allows connecting to ClustersPage: clusters page in the lib/features/clusters folder
  import 'package:cluster_passport/features/clusters/clusters_page.dart';
  //Paquete que permite conectar a MyClustersPage: página de clusters propios en la carpeta lib/features/my_clusters
  //Package that allows connecting to MyClustersPage: my clusters page in the lib/features/my_clusters folder
  import 'package:cluster_passport/features/my_clusters/my_clusters_page.dart';
  //Paquete que permite conectar a NotifyPage: página de notificaciones en la carpeta lib/features/notify
  //Package that allows connecting to NotifyPage: notifications page in the lib/features/notify folder
  import 'package:cluster_passport/features/notify/notify_page.dart';
  //Paquete que permite conectar a S: internacionalización de la aplicación en la carpeta lib/generated/l10n
  //Package that allows connecting to S: internationalization of the application in the lib/generated/l10n folder
  import 'package:cluster_passport/generated/l10n.dart';
  //Paquete que permite conectar a Flutter: widget principal de la aplicación en la carpeta main.dart
  //Package that allows connecting to Flutter: main widget of the application in main.dart
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
        AuthorizedPage(),

        // Página de autorizaciones
        // Authorized page
        MyClustersPage(),

        // Página de notificaciones
        // Notifications page
        const NotifyPage(),
      ][currentPageIndex],

      // Botón flotante
      // Floating button
      floatingActionButton:
          switchFloatingActionButtonOnPageIndex(currentPageIndex),

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
        destinations: <Widget>[
          //Botón Página de autorizados
          //Authorized page button
          NavigationDestination(
            selectedIcon: const Icon(Icons.sensor_occupied),
            icon: const Icon(Icons.groups),
            label: (S.of(context).Authorized),
          ),

          //Botón Página de clusters
          //Clusters page button
          const NavigationDestination(
            icon: Badge(child: Icon(Icons.location_city)),
            label: 'Cluster',
          ),

          //Botón Página de notificaciones
          //Notifications page button
          const NavigationDestination(
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
          onPressed: () {
            Navigator.pushNamed(context, PageConst.contactUsersPage);
            // Este navegador llama a la página de contactos
            // This navigator calls the contacts page
          },
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
