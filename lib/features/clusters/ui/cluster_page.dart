
import 'package:cluster_passport/features/clusters/ui/my_clusters_page.dart';
import 'package:flutter/material.dart';

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
  // ignore: library_private_types_in_public_api
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
          Unit(name: 'Apto. 1-PB-3', user: 'Usuario 1c'),
          Unit(name: 'Apto. 1-PB-4', user: 'Usuario 1d'),
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
    final double listViewHeight = MediaQuery.of(context).size.height/3 - 56;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cluster.title),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // Acción para el filtro
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Acción para el iltro
                },
              ),

            ],
          ),
        ],
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
