import 'package:flutter/material.dart';

class FAQ_Page extends StatelessWidget {
  const FAQ_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ Page'),
      ),
      body: const Center(
        child: Text(
          'This is a basic FAQ page.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
