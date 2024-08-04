import 'package:flutter/material.dart';

class IconAppBarHomePage extends StatelessWidget {
  const IconAppBarHomePage({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onPressed;
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
    ); // Agrega color y size al Icon
  }
}