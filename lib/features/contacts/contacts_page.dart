import 'package:flutter/material.dart';
//import './contacts_controller.dart';

class ContactsPage extends StatelessWidget {
//    final ContactsController _controller;
  const ContactsPage({super.key});
//        required ContactsController controller,
//    }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Select Contact'),
      ),
      body: ListView.builder(itemCount: 5, itemBuilder:(context, index){
        return ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset("assets/images/profile_default.png"),
            ),
          ),
          title: const Text("Username"),
          subtitle: const Text("Hey there! I'm using Cluster Passport"),
        );
      }),
    );
  }
}
