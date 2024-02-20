// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_log/pages/about_us_page/about_page.dart';
import 'package:flutter_log/pages/faqs_page/FAQ_page.dart';
import 'package:flutter_log/pages/profile_page/profile_page.dart';
import 'package:flutter_log/pages/ratings_page/rating_page.dart';
import 'package:flutter_log/pages/recipe_generation_page/generation_page.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/add_remove_ingredients_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
          backgroundColor: Colors.green[700],
          toolbarHeight: MediaQuery.of(context).size.height * 0.06,
          shape: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.75,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
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
                title: Row(
                  children: [
                    const Text('User Profile', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Icon(Icons.person, size: 30),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text('Generate Recipe',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Icon(Icons.generating_tokens, size: 35),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GenerationPage()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text('Add Recipe', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Icon(Icons.add, size: 30),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RatingPage()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text('Add/Remove Ingredients',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Icon(Icons.edit, size: 35),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddRemoveIngredients()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text('FAQ', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Icon(Icons.question_answer, size: 30),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FAQ_Page()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text('About Us', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Icon(Icons.info, size: 30),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutUsPage()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text('Log Out', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Icon(Icons.logout, size: 30),
                  ],
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
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.009),
                Container(
                  //Ui Panel Height & Width
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.95,

                  decoration: BoxDecoration(
                    //Ui Panel Styling
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal[600],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Lets End Food Waste Together!',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
