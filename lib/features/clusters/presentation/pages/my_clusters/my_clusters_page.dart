import 'package:cluster_passport/features/clusters/a_cluster/presentation/pages/cluster_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Cluster {
  final int id;
  final String clusterType;
  final String profileImage; // URL o path de la imagen
  final String title;
  final String subtitle;
  final String clusterAddress;
  final bool clusterState; // Indica si tiene estados nuevos o no
  final IconData icon;

  Cluster({
    required this.id,
    required this.clusterType,
    required this.profileImage,
    required this.title,
    required this.subtitle,
    required this.clusterAddress,
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
      clusterAddress: '58H7+5V2, Lechería 6016, Anzoátegui',
      clusterState: true,
      icon: Icons.directions,
    ),
    Cluster(
      id: 2,
      clusterType: 'Residencial',
      profileImage: 'assets/images/loma_linda.png',
      title: 'Conjunto Residencial Loma Linda',
      subtitle: 'Mi hogar',
      clusterAddress: '4321 Avenida Siempre Viva, Ciudad, País',
      clusterState: false,
      icon: Icons.directions,
    ),
    Cluster(
      id: 3,
      clusterType: 'Residencial',
      profileImage: 'assets/images/el_remanso.png',
      title: 'Conjunto Residencial El Remanso',
      subtitle: 'Mi hogar',
      clusterAddress: '5844+95M, Barcelona 6001, Anzoátegui',
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
                  'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(cluster.clusterAddress)}';
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
