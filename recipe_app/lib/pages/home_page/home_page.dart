// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_log/pages/about_us_page/about_page.dart';
import 'package:flutter_log/pages/add_recipe_page/add_recipe.dart';
import 'package:flutter_log/pages/faqs_page/FAQ_page.dart';
import 'package:flutter_log/pages/home_page/food_notifications/notifications.dart';
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
  NotificationManager notificationManager = NotificationManager();

  @override
  void initState() {
    super.initState();

    // Call the function to notify expired ingredients when the page is loaded
    _notifyExpiredIngredients();
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      print('Signed out');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> _notifyExpiredIngredients() async {
    // Call the function to remove expired ingredients and get the details
    List<Map<String, String>> removedIngredients =
        await notificationManager.removeExpiredIngredientsAndNotify();

    if (removedIngredients.isNotEmpty) {
      // Display a pop-up with the names and expiry dates of removed expired ingredients
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Expired Ingredients Removed'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: removedIngredients
                    .map(
                      (ingredientDetails) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '${ingredientDetails['name']} - Expiry Date: ${ingredientDetails['expiryDate']}',
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('', style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.green[700],
          toolbarHeight: MediaQuery.of(context).size.height * 0.06,
          shape: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.79,
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
                    Icon(Icons.person, size: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    const Text('User Profile', style: TextStyle(fontSize: 20)),
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
                    Icon(Icons.generating_tokens, size: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    const Text('Generate Recipe',
                        style: TextStyle(fontSize: 20)),
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
                    Icon(Icons.cookie, size: 29),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    const Text('Add Recipe', style: TextStyle(fontSize: 20)),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddRecipe()));
                },
              ),
              
            
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.edit, size: 28),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    const Text('Ingredients Manager',
                        style: TextStyle(fontSize: 20)),
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
                    Icon(Icons.question_answer, size: 28),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    const Text('FAQ', style: TextStyle(fontSize: 20)),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FAQ_page()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.info, size: 28),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text('About Us', style: TextStyle(fontSize: 20)),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.logout, size: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    const Text('Log Out', style: TextStyle(fontSize: 20)),
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
        body: Center(
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Image(
              width: 280,
              image: AssetImage(
                'assets/images/logo/logo.png',
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.9,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "Welcome to WasteAway",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
