

import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passport",
                            style:TextStyle(
                              fontSize: 20,
                              color: greyColor,
                              fontWeight: FontWeight.w600,
                          ),
                        ),
      ),

      
    );
  }
}