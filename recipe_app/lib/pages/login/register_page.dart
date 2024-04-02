import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_log/auth/appleSignIn.dart';
import 'package:flutter_log/auth/googleSignIn.dart';
import 'package:flutter_log/pages/home_page/home_page.dart';
import 'package:flutter_log/pages/login/register_login_manager.dart';
import 'package:flutter_log/pages/login/ui_components/button_forget.dart';
import 'package:flutter_log/pages/login/ui_components/login_or_register.dart';
import 'package:flutter_log/pages/login/ui_components/login_tile.dart';
import 'package:flutter_log/pages/login/ui_components/logo_tile.dart';
import 'package:flutter_log/pages/login/ui_components/text_fields.dart';

// DO NOT TOUCH THIS CODE
class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  // Appropriate Logic Manager
  final registerLoginManager = RegisterLoginManager();

  // Text Editing Controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final GoogleSignInHandler _googleSignInHandler = GoogleSignInHandler();

  final AppleSignInHandler _appleSignInHandler = AppleSignInHandler();

  void showOSError() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Android Users: Sign In with Google"),
          );
        });
  }

  // Sign User Up
  void signUserUp() async {
    final String email = emailController.text.trim();
    final String trimmedPassword = passwordController.text.trim();
    final String trimmedConfirmPassword = confirmPasswordController.text.trim();
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
              title: Text("Incorrect Email Address or Already Signed Up"),
            );
          });
    }

    try {
      if (registerLoginManager.confirmPassword(
          trimmedPassword, trimmedConfirmPassword)) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: trimmedPassword,
        );
      } else {
        showErrorMessage("Passwords do not match");
      }

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop Context
      Navigator.pop(context);
      // Wrong Username
      showErrorMessage(e.code);
    }
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
                const SizedBox(height: 25),
                // Logo Textfield
                const LogoTiling(
                    imagePath: 'lib/fitnessImage/fitnessLogo.jpeg'),

                const SizedBox(height: 25),

                Text(
                  'Let\'s create your account!',
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

                MyTextField(
                  control: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // Sign in Buttons
                ButtonForget(
                  onTap: signUserUp,
                  text: 'Sign Up',
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
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AuthScreen(),
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
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Now',
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
