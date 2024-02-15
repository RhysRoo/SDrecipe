import 'package:flutter/material.dart';

class FAQ_Page extends StatelessWidget {
  const FAQ_Page({super.key});

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
          'This is a basic FAQ page.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
