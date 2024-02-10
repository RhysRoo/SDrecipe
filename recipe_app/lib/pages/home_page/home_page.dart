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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sustainability', style: TextStyle(fontSize: 45)),
          backgroundColor: Colors.lightGreen[900],
          toolbarHeight: MediaQuery.of(context).size.height * 0.06,
          shape: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  child: Text(
                    'Menu',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      const Text('User Profile',
                          style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Icon(Icons.person, size: 30),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      const Text('Generate Recipe',
                          style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Icon(Icons.generating_tokens, size: 35),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      const Text('Add Recipe', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Icon(Icons.add, size: 30),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      const Text('FAQ', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Icon(Icons.question_answer, size: 30),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      const Text('About Us', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Icon(Icons.info, size: 30),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      const Text('Log Out', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Icon(Icons.logout, size: 30),
                    ],
                  ),
                ),
                onTap: () {
                  _signOut();
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.green[200],
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.14,
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  //Ui Panel
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.9,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal[600],
                  ),

                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
