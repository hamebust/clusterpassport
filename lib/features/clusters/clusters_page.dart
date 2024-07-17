import 'package:flutter/material.dart';

class ClustersPage extends StatefulWidget {
  const ClustersPage({super.key});
  @override
  State<ClustersPage> createState() => _ClustersPageState();
}

class _ClustersPageState extends State<ClustersPage> {
  void _mostrarDialogoFiltro(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filtrar por Tipo'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Agrega aquí los filtros (Residencial, Mall, Empresa)
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  String _searchTerm = ''; // Para almacenar el término de búsqueda

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de navegación  
      // Navigation bar
      appBar: AppBar(

        // Botón de retroceso
        // Back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        // Título de la página
        // Page title
        title: const Text('Clusters'),
        actions: [
          
          
          const SizedBox(
            width: 50,
          ),

          // Botón de filtro
          // Filtro button
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Acción al presionar el icono de filtro
              _mostrarDialogoFiltro(context);
            },
          ),

          // Botón de búsqueda
          // Search button
          Expanded(
            // Para que el TextField ocupe el espacio disponible
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    _searchTerm = text;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Buscar clusters...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          
        ],
      ),
      body: Column(
        children: [
          Expanded(
            // Para que la lista ocupe el espacio disponible
            child: ListView(
              children:  [
                _ClusterItem(
                  nombre: 'Conjunto Residencial Las Palmeras',
                  tipo: 'Residencial',
                  visible: _searchTerm.isEmpty || 'Conjunto Residencial Las Palmeras'.toLowerCase().contains(_searchTerm.toLowerCase()),
                  // Agrega aquí la imagen o icono del conjunto residencial
                ),
                _ClusterItem(
                  nombre: 'Centro Comercial El Dorado',
                  tipo: 'Mall',
                  visible: _searchTerm.isEmpty || 'Centro Comercial El Dorado'.toLowerCase().contains(_searchTerm.toLowerCase()),
                  // Agrega aquí la imagen o icono del centro comercial
                ),
                _ClusterItem(
                  nombre: 'Empresa Acme S.A.',
                  tipo: 'Empresa',
                  visible: _searchTerm.isEmpty || 'Empresa Acme S.A.'.toLowerCase().contains(_searchTerm.toLowerCase()),
                  // Agrega aquí la imagen o icono de la empresa
                ),
                // Agrega más _ClusterItem según sea necesario
              ],
            ),
          ),
          Padding(
            // Para el botón de crear cluster
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón de crear cluster
                // Navega a la pantalla de creación de cluster
              },
              child: const Text('Crear Cluster'),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para cada item de la lista
class _ClusterItem extends StatelessWidget {
  final String nombre;
  final String tipo;
  final bool visible;
  // Agrega aquí un parámetro para la imagen o icono

  const _ClusterItem({
    required this.nombre,
    required this.tipo,
    required this.visible,
    // Agrega aquí el parámetro para la imagen o icono
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) {
    return const SizedBox.shrink(); // No muestra el cluster si visible es false
  }
    return ListTile(
      //leading: // Muestra aquí la imagen o icono del cluster
      title: Text(nombre), // Muestra el nombre del cluster
      subtitle: Text(tipo),
    );
  }
} // Muestra el tipo de cluster


