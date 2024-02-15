import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Profile Page'),
      ),
      backgroundColor: Colors.green[200],
      body: const Center(
        child: Text(
          'This is a basic Profile page.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
