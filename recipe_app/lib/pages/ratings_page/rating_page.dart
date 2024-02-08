import 'package:flutter/material.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating Page'),
      ),
      body: const Center(
        child: Text(
          'This is a basic Ratings page.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
