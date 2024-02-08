import 'package:flutter/material.dart';

class GenerationPage extends StatelessWidget {
  const GenerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generation Page'),
      ),
      body: const Center(
        child: Text(
          'This is a basic Recipe Generation page.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
