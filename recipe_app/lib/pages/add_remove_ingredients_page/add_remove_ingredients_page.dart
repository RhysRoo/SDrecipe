import 'package:flutter/material.dart';

class AddRemoveIngredients extends StatelessWidget {
  const AddRemoveIngredients({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Add and Remove Ingredients Page'),
      ),
      backgroundColor: Colors.green[200],
      body: const Center(
        child: Text(
          'This is a AddAddRemoveIngredients',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
