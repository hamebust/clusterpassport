import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import './notify_controller.dart';

class NotifyPage extends StatelessWidget {
// ignore: unused_field
// final NotifyController _controller;

  const NotifyPage({super.key});
//        Key? key,
//        required NotifyController controller,
//      }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset("assets/profile_default.png"),
                ),
              ),
              title: const Text("Username"),
              subtitle: const Text("The last access"),
              trailing: Text(DateFormat.jm().format(DateTime.now()),
                  style: const TextStyle(
                    color: greyColor,
                    fontSize: 13,
                  )),
            );
          }),
    );
  }
}
