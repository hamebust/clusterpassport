import 'package:cluster_passport/features/app/home/widgets_home/icon_appbar_home_page.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
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
        title: Text(
          S.of(context).Passport0,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
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
              iconAppBarHomePage(
                  icon: Icons.search,
                  color: greyColor,
                  size: 28,
                  onPressed: () {}),
              const SizedBox(
                width: 20,
              ),
              iconAppBarHomePage(
                  icon: Icons.more_vert,
                  color: greyColor,
                  size: 28,
                  onPressed: () {}),
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
        /// Home page
        const Card(
          shadowColor: Colors.transparent,
          margin: EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
              ),
            ),
          ),
        ),

        // Página de autorizaciones
        // Authorized page
        // Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
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
          NavigationDestination(
            selectedIcon: Icon(Icons.sensor_occupied),
            icon: Icon(Icons.home_outlined),
            label: 'Autorized',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.location_city)),
            label: 'Cluster',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
        ],
      ),
    );
  }

  // Estado del boton flotante
  // Floating button state
  switchFloatingActionButtonOnPageIndex(currentPageIndex) {
    switch (currentPageIndex) {
      case 0:
        return FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        );
      case 1:
        return FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_card),
        );
      case 2:
        return FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        );
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
