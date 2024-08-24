import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Cluster {
  final int id;
  final String clusterType;
  final String profileImage; // URL o path de la imagen
  final String title;
  final String subtitle;
  final String address;
  final bool clusterState; // Indica si tiene estados nuevos o no
  final IconData icon;

  Cluster({
    required this.id,
    required this.clusterType,
    required this.profileImage,
    required this.title,
    required this.subtitle,
    required this.address,
    required this.clusterState,
    required this.icon,
  });
}

class MyClustersPage extends StatelessWidget {
  MyClustersPage({super.key});

  final List<Cluster> myclusters = [
    Cluster(
      id: 1,
      clusterType: 'Trabajo',
      profileImage: 'assets/images/oleus.png',
      title: 'Centro Comercial Oleus',
      subtitle: 'Mi trabajo',
      address: '58H7+5V2, Lechería 6016, Anzoátegui',
      clusterState: true,
      icon: Icons.directions,
    ),
    Cluster(
      id: 2,
      clusterType: 'Residencial',
      profileImage: 'assets/images/loma_linda.png',
      title: 'Conjunto Residencial Loma Linda',
      subtitle: 'Mi hogar',
      address: '4321 Avenida Siempre Viva, Ciudad, País',
      clusterState: false,
      icon: Icons.directions,
    ),
    Cluster(
      id: 3,
      clusterType: 'Residencial',
      profileImage: 'assets/images/el_remanso.png',
      title: 'Conjunto Residencial El Remanso',
      subtitle: 'Mi hogar',
      address: '5844+95M, Barcelona 6001, Anzoátegui',
      clusterState: true,
      icon: Icons.directions,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Clusters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: myclusters.length,
          itemBuilder: (context, index) {
            return ClusterCard(cluster: myclusters[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para agregar un nuevo cluster
          Navigator.pushNamed(context, '/add_cluster');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ClusterCard extends StatelessWidget {
  final Cluster cluster;

  const ClusterCard({super.key, required this.cluster});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          // 1. Imagen del perfil con borde según el estado del cluster
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: cluster.clusterState ? Colors.green : Colors.grey,
                width: 3.0,
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(cluster.profileImage),
            ),
          ),

          // 2. Título y subtítulo en el centro envueltos en un InkWell para detectar toques
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClusterPage(cluster: cluster),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cluster.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      cluster.subtitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. Icono de direcciones y apertura de Google Maps
          IconButton(
            icon: Icon(cluster.icon),
            onPressed: () async {
              final url =
                  'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(cluster.address)}';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }
}

class Unit {
  final String name;
  final String user; // Nuevo campo para almacenar el nombre del usuario

  Unit({required this.name, required this.user});
}

class Area {
  final String name;
  final String user; // Nuevo campo para almacenar el nombre del usuario
  final List<Unit> units;

  Area({required this.name, required this.user, required this.units});
}

class ClusterPage extends StatefulWidget {
  final Cluster cluster;

  const ClusterPage({super.key, required this.cluster});

  @override
  _ClusterPageState createState() => _ClusterPageState();
}

class _ClusterPageState extends State<ClusterPage> {
  // Lista de áreas y unidades
  late List<Area> areas;
  List<Unit> selectedUnits = [];

  @override
  void initState() {
    super.initState();
    // Inicializamos las áreas con sus respectivas unidades
    areas = [
      Area(
        name: 'Torre 1',
        user: 'Usuario 1',
        units: [
          Unit(name: 'Apto. 1-PB-1', user: 'Usuario 1A'),
          Unit(name: 'Apto. 1-PB-2', user: 'Usuario 1B'),
          // Otros apartamentos...
        ],
      ),
      Area(
        name: 'Torre 2',
        user: 'Usuario 2',
        units: [
          Unit(name: 'Apto. 2A', user: 'Usuario 2A'),
          Unit(name: 'Apto. 2B', user: 'Usuario 2B'),
        ],
      ),
      Area(
        name: 'Torre 3',
        user: 'Usuario 3',
        units: [
          Unit(name: 'Apto. 3A', user: 'Usuario 3A'),
          Unit(name: 'Apto. 3B', user: 'Usuario 3B'),
        ],
      ),
    ];

    // Inicializamos las unidades seleccionadas con la primera área
    selectedUnits = areas[0].units;
  }

  @override
  Widget build(BuildContext context) {
    // Calculamos 1/4 de la altura de la pantalla
    final double listViewHeight = MediaQuery.of(context).size.height / 4;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cluster.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de Título con Íconos de Filtro y Búsqueda para Áreas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Áreas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        // Acción para el filtro
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Acción para la búsqueda
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // ListView para las Áreas con altura limitada
            SizedBox(
              height: listViewHeight,
              child: ListView.builder(
                itemCount: areas.length,
                itemBuilder: (context, index) {
                  final area = areas[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(area.name),
                          Text(area.user, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        setState(() {
                          selectedUnits = area.units;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Sección de Título con Íconos de Filtro y Búsqueda para Unidades
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Unidades',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        // Acción para el filtro
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Acción para la búsqueda
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // ListView para las Unidades con altura limitada
            SizedBox(
              height: listViewHeight,
              child: ListView.builder(
                itemCount: selectedUnits.length,
                itemBuilder: (context, index) {
                  final unit = selectedUnits[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(unit.name),
                          Text(unit.user, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Acción de navegación para unidades
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Barra Inferior Vacía para futuras acciones
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 40.0, // Altura de la barra inferior
          color: Colors.blueGrey,
          child: const Center(
            child: Text(
              'Barra Inferior',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
