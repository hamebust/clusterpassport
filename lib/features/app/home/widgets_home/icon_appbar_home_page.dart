import 'package:flutter/material.dart';

class IconAppBarHomePage extends StatelessWidget {
  const IconAppBarHomePage({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
    required this.onPressed,
  });
  final IconData icon; // Cambia el tipo a IconData
  final Color color;
  final double size;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton( // Usa IconButton en lugar de Icon
      onPressed: onPressed, 
      icon: Icon(icon, color: color, size: size),); // Agrega color y size al Icon
  }
}