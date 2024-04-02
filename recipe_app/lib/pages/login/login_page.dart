// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_log/auth/appleSignIn.dart';
import 'package:flutter_log/auth/googleSignIn.dart';
import 'package:flutter_log/pages/login/auth_page.dart';
import 'package:flutter_log/pages/login/ui_components/button_forget.dart';
import 'package:flutter_log/pages/login/ui_components/login_tile.dart';
import 'package:flutter_log/pages/login/ui_components/logo_tile.dart';
import 'package:flutter_log/pages/login/ui_components/text_fields.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// DO NOT TOUCH THIS CODE
class _LoginPageState extends State<LoginPage> {
  // Text Editing Controller

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Google Sign In
  final GoogleSignInHandler _googleSignInHandler = GoogleSignInHandler();

  // Apple Sign In
  final AppleSignInHandler _appleSignInHandler = AppleSignInHandler();

  // Sign User In
  void signUserIn() async {
    // Loading Circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    void showErrorMessage(String message) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Incorrect Email Address"),
            );
          });
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Add User Details

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop Context
      Navigator.pop(context);
      // Wrong Username
      showErrorMessage(e.code);
    }
  }

  void showOSError() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Android Users: Sign In with Google"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Aligned for iOS phones
              children: [
                const SizedBox(height: 50),
                // Logo Textfield
                const LogoTiling(
                    imagePath: 'lib/fitnessImage/fitnessLogo.jpeg'),

                const SizedBox(height: 50),

                Text(
                  'Welcome Back you\'ve been missed',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // Username TextField
                MyTextField(
                  control: emailController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Password TextField
                MyTextField(
                  control: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Forgot Password

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Sign in Buttons
                ButtonForget(
                  onTap: signUserIn,
                  text: 'Sign In',
                ),

                const SizedBox(height: 50),

                //Google + Apple Sign In Prompt
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
                // Google + Apple sign in buttons

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Button
                    LogTile(
                        onTap: () => _googleSignInHandler.handleSignIn(context),
                        imagePath: 'lib/fitnessImage/GoogleLogo.png'),

                    const SizedBox(width: 25),

                    //Apple Button
                    LogTile(
                        onTap: () async => {
                              if (Platform.isIOS)
                                {
                                  await _appleSignInHandler
                                      .handleSignIn(context),
                                  if (FirebaseAuth.instance.currentUser != null)
                                    {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AuthPage(),
                                        ),
                                      )
                                    }
                                }
                              else
                                {showOSError()}
                            },
                        imagePath: 'lib/fitnessImage/AppleLogo.png')
                  ],
                ),

                const SizedBox(height: 60),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
