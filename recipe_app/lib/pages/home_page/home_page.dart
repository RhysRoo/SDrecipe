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
              SizedBox(height: MediaQuery.of(context).size.height * 0.009),
              Container(
                //Ui Panel
                height: MediaQuery.of(context).size.height * 0.67,
                width: MediaQuery.of(context).size.width * 0.95,

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
          //Navbar
          Align(
            //Bottom Nav Bar
            alignment: const Alignment(0.0, 1.0),
            child: Container(
              color: Colors.green[600],
              height: MediaQuery.of(context).size.height * 0.177,
              width: MediaQuery.of(context).size.width * 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        //Top Container
                        Container(
                          //Left Button
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.black,
                          child: MaterialButton(
                            color: Colors.purple,
                            onPressed: () {},
                            child: const Icon(Icons.rate_review, size: 40),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          //Middle Button
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.black,
                          child: MaterialButton(
                            color: Colors.purple,
                            onPressed: () {},
                            child: const Icon(Icons.add, size: 40),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          //Sign Out Button (Right Btn)
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.black,
                          child: MaterialButton(
                            color: Colors.purple,
                            onPressed: () {},
                            child: const Icon(Icons.info_sharp, size: 40),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.014,
                    ),
                    Row(
                      children: [
                        //Bottom Container
                        Container(
                          //Left Button
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.black,
                          child: MaterialButton(
                            color: Colors.purple,
                            onPressed: () {},
                            child:
                                const Icon(Icons.generating_tokens, size: 40),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          //Middle Button
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.black,
                          child: MaterialButton(
                            color: Colors.purple,
                            onPressed: () {},
                            child: const Icon(Icons.person, size: 40),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          //Sign Out Button (Right Btn)
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.black,
                          child: MaterialButton(
                            color: Colors.purple,
                            onPressed: () {
                              _signOut();
                            },
                            child: const Icon(Icons.logout, size: 40),
                          ),
                        ),
                      ],
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
