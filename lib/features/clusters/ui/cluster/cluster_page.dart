
import 'package:cluster_passport/features/clusters/ui/my_clusters/my_clusters_page.dart';
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
        user: 'Administrador 1',
        units: [
          Unit(name: 'Apto. 1-PB-1', user: 'Usuario 01'),
          Unit(name: 'Apto. 1-PB-2', user: 'Usuario 02'),
          Unit(name: 'Apto. 1-PB-3', user: 'Usuario 03'),
          Unit(name: 'Apto. 1-PB-4', user: 'Usuario 04'),
          Unit(name: 'Apto. 1-1-1', user: 'Usuario 05'),
          Unit(name: 'Apto. 1-1-2', user: 'Usuario 06'),
          Unit(name: 'Apto. 1-1-3', user: 'Usuario 07'),
          Unit(name: 'Apto. 1-1-4', user: 'Usuario 08'),
          Unit(name: 'Apto. 1-1-5', user: 'Usuario 09'),
          Unit(name: 'Apto. 1-1-6', user: 'Usuario 10'),
          Unit(name: 'Apto. 1-1-7', user: 'Usuario 11'),
          Unit(name: 'Apto. 1-1-8', user: 'Usuario 12'),
          Unit(name: 'Apto. 1-2-1', user: 'Usuario 13'),
          Unit(name: 'Apto. 1-2-2', user: 'Usuario 14'),
          Unit(name: 'Apto. 1-2-3', user: 'Usuario 15'),
          Unit(name: 'Apto. 1-2-4', user: 'Usuario 16'),
          Unit(name: 'Apto. 1-2-5', user: 'Usuario 17'),
          Unit(name: 'Apto. 1-2-6', user: 'Usuario 18'),
          Unit(name: 'Apto. 1-2-7', user: 'Usuario 19'),
          Unit(name: 'Apto. 1-2-8', user: 'Usuario 20'),
          // Otros apartamentos...
        ],
      ),
      Area(
        name: 'Torre 2',
        user: 'Usuario 2',
        units: [
          Unit(name: 'Apto. 2-PB-2', user: 'Usuario 02'),
          Unit(name: 'Apto. 2-PB-1', user: 'Usuario 01'),
          Unit(name: 'Apto. 2-PB-3', user: 'Usuario 03'),
          Unit(name: 'Apto. 2-PB-4', user: 'Usuario 04'),
          Unit(name: 'Apto. 2-1-1', user: 'Usuario 05'),
          Unit(name: 'Apto. 2-1-2', user: 'Usuario 06'),
          Unit(name: 'Apto. 2-1-3', user: 'Usuario 07'),
          Unit(name: 'Apto. 2-1-4', user: 'Usuario 08'),
          Unit(name: 'Apto. 2-1-5', user: 'Usuario 09'),
          Unit(name: 'Apto. 2-1-6', user: 'Usuario 10'),
          Unit(name: 'Apto. 2-1-7', user: 'Usuario 11'),
          Unit(name: 'Apto. 2-1-8', user: 'Usuario 12'),
          Unit(name: 'Apto. 2-2-1', user: 'Usuario 13'),
          Unit(name: 'Apto. 2-2-2', user: 'Usuario 14'),
          Unit(name: 'Apto. 2-2-3', user: 'Usuario 15'),
          Unit(name: 'Apto. 2-2-4', user: 'Usuario 16'),
          Unit(name: 'Apto. 2-2-5', user: 'Usuario 17'),
          Unit(name: 'Apto. 2-2-6', user: 'Usuario 18'),
          Unit(name: 'Apto. 2-2-7', user: 'Usuario 19'),
          Unit(name: 'Apto. 2-2-8', user: 'Usuario 20'),
        ],
      ),
      Area(
        name: 'Torre 3',
        user: 'Usuario 3',
        units: [
          Unit(name: 'Apto. 3-PB-1', user: 'Usuario 01'),
          Unit(name: 'Apto. 3-PB-2', user: 'Usuario 02'),
          Unit(name: 'Apto. 3-PB-3', user: 'Usuario 03'),
          Unit(name: 'Apto. 3-PB-4', user: 'Usuario 04'),
          Unit(name: 'Apto. 3-1-1', user: 'Usuario 05'),
          Unit(name: 'Apto. 3-1-2', user: 'Usuario 06'),
          Unit(name: 'Apto. 3-1-3', user: 'Usuario 07'),
          Unit(name: 'Apto. 3-1-4', user: 'Usuario 08'),
          Unit(name: 'Apto. 3-1-5', user: 'Usuario 09'),
          Unit(name: 'Apto. 3-1-6', user: 'Usuario 10'),
          Unit(name: 'Apto. 3-1-7', user: 'Usuario 11'),
          Unit(name: 'Apto. 3-1-8', user: 'Usuario 12'),
          Unit(name: 'Apto. 3-2-1', user: 'Usuario 13'),
          Unit(name: 'Apto. 3-2-2', user: 'Usuario 14'),
          Unit(name: 'Apto. 3-2-3', user: 'Usuario 15'),
          Unit(name: 'Apto. 3-2-4', user: 'Usuario 16'),
          Unit(name: 'Apto. 3-2-5', user: 'Usuario 17'),
          Unit(name: 'Apto. 3-2-6', user: 'Usuario 18'),
          Unit(name: 'Apto. 3-2-7', user: 'Usuario 19'),
          Unit(name: 'Apto. 3-2-8', user: 'Usuario 20'),
        ],
      ),
    ];

    // Inicializamos las unidades seleccionadas con la primera área
    selectedUnits = areas[0].units;
  }

  @override
  Widget build(BuildContext context) {
    // Calculamos 1/4 de la altura de la pantalla
    final double listViewHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cluster.title),
        // actions: [
        //   Row(
        //     children: [
        //       IconButton(
        //         icon: const Icon(Icons.filter_list),
        //         onPressed: () {
        //           // Acción para el filtro
        //         },
        //       ),
        //       IconButton(
        //         icon: const Icon(Icons.more_vert),
        //         onPressed: () {
        //           // Acción para el iltro
        //         },
        //       ),

        //     ],
        //   ),
        // ],
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
              height: listViewHeight/5 + 10,
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
              height: listViewHeight/3 + 40,
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

    );
  }
}
