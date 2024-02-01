import 'dart:ffi';

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
      backgroundColor: Colors.green[200],
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                //Sign Out Button
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.14,
                  ),
                  const Align(
                    child: Text(
                      //Home Page Title
                      'Sustainability ',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            //Nav Bar
            alignment: Alignment(0.0, 1.0),
            child: Container(
              color: Colors.cyan,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      //Left Button
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: Colors.black,
                      child: MaterialButton(
                        color: Colors.pink,
                        onPressed: () {},
                        child: Icon(Icons.access_alarm_outlined, size: 40),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      //Middle Button
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: Colors.black,
                      child: MaterialButton(
                        color: Colors.pink,
                        onPressed: () {},
                        child: Icon(Icons.accessibility_new_outlined, size: 40),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      //Right Button
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: Colors.black,
                      child: MaterialButton(
                        color: Colors.pink,
                        onPressed: () {
                          _signOut();
                        },
                        child: Icon(Icons.logout, size: 40),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
