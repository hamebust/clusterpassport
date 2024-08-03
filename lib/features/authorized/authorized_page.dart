import 'package:flutter/material.dart';

class AuthorizedPage extends StatelessWidget {
  AuthorizedPage({super.key});

  // Lista de personas autorizadas
  // List of authorized people
  final List<Map<String, String>> authorizedPeople = [
    {
      'icon': 'person',
      'title': 'Ambar Medina',
      'subtitle': 'Mi hermana / C.R. El Remanso'
    },
    {
      'icon': 'person_2',
      'title': 'Euclides',
      'subtitle': 'Trabajador / C.C. Oleus'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: authorizedPeople.length,
          itemBuilder: (context, index) {
            final person = authorizedPeople[index];
            return Card(
              child: ListTile(
                leading: Icon(
                  person['icon'] == 'person' ? Icons.person : Icons.person_2,
                  size: 30,
                ),
                title: Text(person['title']!),
                subtitle: Text(person['subtitle']!),
              ),
            );
          },
        ),
      ),
    );
  }
}
