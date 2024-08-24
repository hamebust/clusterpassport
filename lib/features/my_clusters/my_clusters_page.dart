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

//import 'package:flutter/material.dart';

class Unit {
  final String name;

  Unit({required this.name});
}

class Area {
  final String name;
  final List<Unit> units;

  Area({required this.name, required this.units});
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
        units: [
          Unit(name: 'Apto. 1-PB-1'),
          Unit(name: 'Apto. 1-PB-2'),
          Unit(name: 'Apto. 1-PB-3'),
          Unit(name: 'Apto. 1-PB-4'),
          Unit(name: 'Apto. 1-1-1'),
          Unit(name: 'Apto. 1-1-2'),
          Unit(name: 'Apto. 1-1-3'),
          Unit(name: 'Apto. 1-1-4'),
          Unit(name: 'Apto. 1-1-5'),
          Unit(name: 'Apto. 1-1-6'),
          Unit(name: 'Apto. 1-1-7'),
          Unit(name: 'Apto. 1-1-8'),
          Unit(name: 'Apto. 1-2-1'),
          Unit(name: 'Apto. 1-2-2'),
          Unit(name: 'Apto. 1-2-3'),
          Unit(name: 'Apto. 1-2-4'),
          Unit(name: 'Apto. 1-2-5'),
          Unit(name: 'Apto. 1-2-6'),
          Unit(name: 'Apto. 1-2-7'),
          Unit(name: 'Apto. 1-2-8'),
          Unit(name: 'Apto. 1-3-1'),
          Unit(name: 'Apto. 1-3-2'),
          Unit(name: 'Apto. 1-3-3'),
          Unit(name: 'Apto. 1-3-4'),
          Unit(name: 'Apto. 1-3-5'),
          Unit(name: 'Apto. 1-3-6'),
          Unit(name: 'Apto. 1-3-7'),
          Unit(name: 'Apto. 1-3-8'),
          Unit(name: 'Apto. 1-4-1'),
          Unit(name: 'Apto. 1-4-2'),
          Unit(name: 'Apto. 1-4-3'),
          Unit(name: 'Apto. 1-4-4'),
          Unit(name: 'Apto. 1-4-5'),
          Unit(name: 'Apto. 1-4-6'),
          Unit(name: 'Apto. 1-4-7'),
          Unit(name: 'Apto. 1-4-8'),
        ],
      ),
      Area(
        name: 'Torre 2',
        units: [
          Unit(name: 'Apto. 2A'),
          Unit(name: 'Apto. 2B'),
        ],
      ),
      Area(
        name: 'Torre 3',
        units: [
          Unit(name: 'Apto. 3A'),
          Unit(name: 'Apto. 3B'),
          Unit(name: 'Apto. 3C'),
          Unit(name: 'Apto. 3D'),
        ],
      ),
      Area(
        name: 'Torre 4',
        units: [
          Unit(name: 'Apto. 3A'),
          Unit(name: 'Apto. 3B'),
          Unit(name: 'Apto. 3C'),
          Unit(name: 'Apto. 3D'),
        ],
      ),
      Area(
        name: 'Torre 5',
        units: [
          Unit(name: 'Apto. 3A'),
          Unit(name: 'Apto. 3B'),
          Unit(name: 'Apto. 3C'),
          Unit(name: 'Apto. 3D'),
        ],
      ),
    ];

    // Inicializamos las unidades seleccionadas con la primera área
    selectedUnits = areas[0].units;
  }

    @override
  Widget build(BuildContext context) {
    // Calculamos 1/3 de la altura de la pantalla
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
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: areas.length,
                itemBuilder: (context, index) {
                  final area = areas[index];
                  return ListTile(
                    title: Text(area.name),
                    onTap: () {
                      setState(() {
                        selectedUnits = area.units;
                      });
                    },
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
            Container(
              height: listViewHeight,
              child: ListView.builder(
                itemCount: selectedUnits.length,
                itemBuilder: (context, index) {
                  final unit = selectedUnits[index];
                  return ListTile(
                    title: Text(unit.name),
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
          height: 50.0, // Altura de la barra inferior
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