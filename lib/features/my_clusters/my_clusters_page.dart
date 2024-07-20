import 'package:flutter/material.dart';
//import './my_clusters_controller.dart';
//
//class MyClustersPage extends StatelessWidget {
//
//    final MyClustersController _controller;
//
//    const MyClustersPage({
//        Key? key,
//        required MyClustersController controller,
//      }) : _controller = controller;
//
//    @override
//    Widget build(BuildContext context) {
//        return Scaffold(
//            appBar: AppBar(title: Text('MyClustersPage'),),
//            body: Container(),
//        );
//    }
//}

class MyClustersPage extends StatelessWidget {
  MyClustersPage({super.key});

  final List<Map<String, String>> myclusters = [
    {
      'icon': 'business',
      'title': 'Centro Comercial Oleus',
      'subtitle': 'Mi trabajo'
    },
    {
      'icon': 'apartment',
      'title': 'Conjunto Residencial Loma Linda',
      'subtitle': 'Mi hogar'
    },
    {
      'icon': 'apartment',
      'title': 'Conjunto Residencial El Remanso',
      'subtitle': 'Mi hogar'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: myclusters.length,
          itemBuilder: (context, index) {
            final cluster = myclusters[index];
            return Card(
              child: ListTile(
                leading: Icon(
                  cluster['icon'] == 'business' ? Icons.business : Icons.apartment,
                  size: 30,
                ),
                title: Text(cluster['title']!),
                subtitle: Text(cluster['subtitle']!),
              ),
            );
          },
        ),
      ),
    );
  }
}
