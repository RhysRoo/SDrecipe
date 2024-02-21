// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManager {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> getCurrentUserUID() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        return user.uid;
      } else {
        return ''; // You may want to handle the case when there is no user
      }
    } catch (e) {
      print('Error: $e');
      return ''; // Handle errors by returning an empty string or another default value
    }
  }
}
