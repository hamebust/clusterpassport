// Suggested code may be subject to a license. Learn more: ~LicenseLog:1329871108.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2763786354.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:749039502.
import 'package:flutter/material.dart';

class ChatAuthorizedPage extends StatefulWidget {
  const ChatAuthorizedPage({super.key});

  @override
  State<ChatAuthorizedPage> createState() => _ChatAuthorizedPageState();
}

class _ChatAuthorizedPageState extends State<ChatAuthorizedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ambar Medina'),
            Text('Online', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Mensaje $index'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.attach_file),
                ),
                //IconButton(
                //  onPressed: () {},
                //  icon: const Icon(Icons.mic),
                //),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

