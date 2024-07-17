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
  const MyClustersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.business, size: 30),
                title: Text('Centro Comercial Oleus'),
                subtitle: Text('Mi trabajo'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.apartment, size: 30),
                title: Text('Conjunto Residencial Loma Linda'),
                subtitle: Text('Mi hogar'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.apartment, size: 30),
                title: Text('Conjunto Residencial El Remanso'),
                subtitle: Text('Mi hogar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
