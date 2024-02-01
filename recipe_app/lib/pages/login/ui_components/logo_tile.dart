import 'package:flutter/material.dart';

// A Tile for the logo
class LogoTiling extends StatelessWidget {
  final String imagePath;
  const LogoTiling({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: 70,
      ),
    );
  }
}
