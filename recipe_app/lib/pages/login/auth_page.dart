import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_log/pages/home_page/home_page.dart';
import 'package:flutter_log/pages/login/ui_components/login_or_register.dart';

// DO NOT TOUCH THIS CODE
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // // User is logged in
            if (snapshot.hasData) {
              return const HomePage();
            }

            // // User is not logged in
            else {
              return const LoginOrRegisterPage();
            }
          }),
    );
  }
}
