import 'package:flutter/material.dart';

class AddRecipe extends StatelessWidget {
  const AddRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('FAQ Page'),
      ),
      backgroundColor: Colors.green[200],
      body: const Center(
        child: Text(
          'This is a basic Recipe Addition page.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
