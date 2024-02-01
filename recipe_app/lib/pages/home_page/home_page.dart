import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
      print('Signed in anonymously');
    } catch (e) {
      print('Error signing in anonymously: $e');
    }
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      print('Signed out');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0.0, 0.0),
            child: Container(
              color: Colors.cyan,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
          ),
          ElevatedButton(
            onPressed: _signOut,
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
