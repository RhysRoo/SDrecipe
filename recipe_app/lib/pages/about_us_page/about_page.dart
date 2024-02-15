import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('About Us Page'),
      ),
      backgroundColor: Colors.green[200],
      body: const Center(
        child: Text(
          'This is a About Us Flutter page.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}