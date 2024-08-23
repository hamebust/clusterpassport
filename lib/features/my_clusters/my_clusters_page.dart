import 'package:flutter/material.dart';

class Cluster {
  final IconData icon;
  final String title;
  final String subtitle;

  Cluster({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class MyClustersPage extends StatelessWidget {
  MyClustersPage({super.key});

  final List<Cluster> myclusters = [
    Cluster(
      icon: Icons.business,
      title: 'Centro Comercial Oleus',
      subtitle: 'Mi trabajo',
    ),
    Cluster(
      icon: Icons.apartment,
      title: 'Conjunto Residencial Loma Linda',
      subtitle: 'Mi hogar',
    ),
    Cluster(
      icon: Icons.apartment,
      title: 'Conjunto Residencial El Remanso',
      subtitle: 'Mi hogar',
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
      child: ListTile(
        leading: Icon(
          cluster.icon,
          size: 30,
        ),
        title: Text(cluster.title),
        subtitle: Text(cluster.subtitle),
      ),
    );
  }
}
