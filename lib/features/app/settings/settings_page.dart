import 'package:flutter/material.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:2850830417.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1522323193.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width:65, 
                height:65,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32.5),
                  child: Image.asset("assets/images/profile_default.png")
                ),
              ),

              const SizedBox(width: 10,),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Username", style: TextStyle(fontSize: 18),),
                    Text("while true code{}", style: TextStyle(fontSize: 14),),
                  ],
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}
