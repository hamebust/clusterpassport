import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster_passport/features/app/const/firebase_collection_const.dart';
import 'package:cluster_passport/features/clusters/a_cluster/presentation/cubits/cluster/cluster_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cluster_passport/features/clusters/presentation/pages/search_and_create_cluster/widgets/create_cluster_form.dart';

class SearchAndCreateClustersPage extends StatefulWidget {
  const SearchAndCreateClustersPage({Key? key}) : super(key: key);

  @override
  _SearchAndCreateClustersPageState createState() => _SearchAndCreateClustersPageState();
}

class _SearchAndCreateClustersPageState extends State<SearchAndCreateClustersPage> {
  bool _isCreateClusterFormVisible = false;

  // Alternar la visibilidad del formulario de creación de clúster
  void _toggleCreateFormVisibility() {
    setState(() {
      _isCreateClusterFormVisible = !_isCreateClusterFormVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    // Al inicializar el widget, obtenemos todos los clústeres
    BlocProvider.of<ClusterCubit>(context).getAllClusters();

    // Crear la colección 'clusters' si no existe (con manejo de errores)
    _createClustersCollection();
  }

  Future<void> _createClustersCollection() async {
    try {
      final clusterCollection = FirebaseFirestore.instance.collection(FirebaseCollectionConst.clusters);
      await clusterCollection.add({}); // Agrega un documento vacío para crear la colección
      print('Colección "clusters" creada correctamente');
    } catch (e) {
      // Manejar errores al crear la colección
      print('Error al crear la colección "clusters": $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clusters'),
        actions: [
          IconButton(
            icon: _isCreateClusterFormVisible ? const Icon(Icons.close) : const Icon(Icons.add),
            onPressed: _toggleCreateFormVisibility,
          ),
        ],
      ),
      body: Column(
        children: [
          // Si el formulario de creación es visible, lo mostramos
          if (_isCreateClusterFormVisible)
            CreateClusterForm(
              onClusterCreated: () {
                // Cuando un clúster es creado, refrescamos la lista de clústeres
                BlocProvider.of<ClusterCubit>(context).getAllClusters();
                _toggleCreateFormVisibility();
              }, createClusterUsecase: BlocProvider.of<ClusterCubit>(context).createClusterUsecase,
            ),

          // Usamos BlocBuilder para manejar el estado del cubit
          Expanded(
            child: BlocBuilder<ClusterCubit, ClusterState>(
              builder: (context, state) {
                if (state is ClusterLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ClusterFailure) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is ClusterLoaded) {
                  // Verificamos si hay clusters o no
                  if (state.clusters.isEmpty) {
                    return const Center(child: Text('No existen clusters')); 
                  } else {
                    final clusters = state.clusters;
                    return ListView.builder(
                      itemCount: clusters.length,
                      itemBuilder: (context, index) {
                        final cluster = clusters[index];
                        return ListTile(
                          title: Text(cluster.clusterName),
                          subtitle: Text(cluster.description),
                        );
                      },
                    );
                  }
                } else {
                  return const Center(child: Text('Unexpected state'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
