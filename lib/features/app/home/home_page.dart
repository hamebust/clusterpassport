//HomePage: página principal de la aplicación en la carpeta lib/features/app/home
//HomePage: main page of the application in the lib/features/app/home folder

// Todas las notas son en español e inglés
// All notes are in spanish and english

//Sección de Paquetes
//Packages section
//Paquete que permite conectar a PageConst: constantes en la carpeta lib/features/app/const
//Package that allows connecting to PageConst: page constants in the lib/features/app/const folder
import 'package:cluster_passport/features/app/const/page_const.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:cluster_passport/features/authorized/presentation/pages/authorized/authorized_page.dart';
import 'package:cluster_passport/features/clusters/a_cluster/presentation/cubits/cluster/cluster_cubit.dart';
import 'package:cluster_passport/features/clusters/presentation/pages/my_clusters/my_clusters_page.dart';
import 'package:cluster_passport/features/clusters/presentation/pages/search_and_create_cluster/search_and_create_clusters_page.dart';
import 'package:cluster_passport/features/news/news_page.dart';
import 'package:cluster_passport/features/notify/notify_page.dart';
import 'package:cluster_passport/features/user/presentation/cubits/get_single_user/get_single_user_cubit.dart';
import 'package:cluster_passport/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final String uid;
  final int? index;

  const HomePage({super.key, required this.uid, this.index});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Estas clase define el estado inicial del índice de la página actual a 0.
// These class define the initial state of the current page index to 0.
class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
  }

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
          const Icon(Icons.camera_alt_outlined, color: greyColor, size: 28),
          const SizedBox(width: 25),
          const Icon(Icons.search, color: greyColor, size: 28),
          const SizedBox(width: 10),

          // Botón de perfil
          // Profile button
          
          BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
            builder: (context, state) {
              if (state is GetSingleUserLoaded) {
                final singleUser = state.singleUser;
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PageConst.settingsPage,
                      arguments: widget.uid,
                    );
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(4.0), // Ajusta el padding según sea necesario
                      child: CircleAvatar(
                      radius: 22, // Ajusta el tamaño del avatar si es necesario
                      backgroundImage: singleUser.profileUrl != null &&
                              singleUser.profileUrl!.isNotEmpty
                          ? NetworkImage(singleUser
                              .profileUrl!) // Uso de ! para asegurar que no es nulo
                          : const AssetImage("assets/default_profile.png")
                              as ImageProvider, // Imagen predeterminada
                    ),
                  ),
                );
              } else {
                // Muestra un ícono de carga o una imagen predeterminada mientras se cargan los datos
                return const CircleAvatar(
                  radius: 18,
                  backgroundColor: greyColor,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

          const SizedBox(width: 10),
        ],
      ),

      backgroundColor: Theme.of(context).colorScheme.onPrimary,

      // Cuerpo de la aplicación
      body: IndexedStack(index: currentPageIndex, children: <Widget>[
        // Cuerpo de la aplicación
        // App body

        // Página de Autorizados
        // Authorized page
        AuthorizedPage(),

        // Página de mis clusters
        // My clusters page
        MyClustersPage(),

        // Página de Novedades
        // New page
        const NewsPage(),

        // Página de notificaciones
        // Notifications page
        const NotifyPage(),
      ]),

      // Botón flotante
      // Floating button
      floatingActionButton:
          _switchFloatingActionButtonOnPageIndex(currentPageIndex),

      // Barra de navegación inferior
      // Bottom navigation bar
      bottomNavigationBar: NavigationBar(
        //
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

          //Botón Página Estatus de los clusters
          //Status page button
          const NavigationDestination(
            icon: Badge(child: Icon(Icons.circle_notifications)),
            label: 'News',
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
  Widget? _switchFloatingActionButtonOnPageIndex(int currentPageIndex) {
    switch (currentPageIndex) {
      // Boton de agregar usuario
      // Add user button
      case 0:
        return FloatingActionButton(
          onPressed: () {
            // Este navegador llama a la página de contactos
            // This navigator calls the contacts page
            Navigator.pushNamed(context, PageConst.contactUsersPage);
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
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ClusterCubit(
                    createClusterUsecase: BlocProvider.of<ClusterCubit>(context).createClusterUsecase,
                    deleteSingleClusterUsecase: BlocProvider.of<ClusterCubit>(context).deleteSingleClusterUsecase,
                    getAllClusterUsecase: BlocProvider.of<ClusterCubit>(context).getAllClusterUsecase,
                    getSingleClusterUsecase: BlocProvider.of<ClusterCubit>(context).getSingleClusterUsecase,
                    updateClusterUsecase: BlocProvider.of<ClusterCubit>(context).updateClusterUsecase,
                  ),
                  child: const SearchAndCreateClustersPage(),
                ),
              ),
            );
          },
          child: const Icon(Icons.add_card),
        );

      default:
        return null;
    }
  }

}
