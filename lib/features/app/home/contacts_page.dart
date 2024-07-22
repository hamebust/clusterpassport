import 'package:flutter/material.dart';
//import './authorized_controller.dart';

class Contacts2Page extends StatelessWidget {
  // ignore: unused_field
  // final AuthorizedController _controller;

  // ignore: use_key_in_widget_constructors
  const Contacts2Page({super.key});
  //      Key? key,
  //      required AuthorizedController controller,
  //    }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.person, size: 30),
                title: Text('Ambar Medina'),
                subtitle: Text('Mi hermana / C.R. El Remanso'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.person_2, size: 30),
                title: Text('Euclides'),
                subtitle: Text('Trabajador / C.C. Oleus'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
