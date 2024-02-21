// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_log/pages/profile_page/userModel.dart';

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

  Future<Map> storeUserDetails(UserModel user) async {
    String uid = await getCurrentUserUID();

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firestore.collection("UserDetails").doc(uid).get();

      if (documentSnapshot.exists) {
        // Return user details as a Map
        return documentSnapshot.data()!;
      } else {
        // Return an empty Map or handle the case when the document doesn't exist
        return {};
      }
    } catch (e) {
      print("Error retrieving user details: $e");
      // Handle errors by returning an empty Map or another default value
      return {};
    }
  }

  Future<Map<String, dynamic>> getUserDetails(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firestore.collection("UserDetails").doc(uid).get();

      if (documentSnapshot.exists) {
        // Return user details as a Map
        return documentSnapshot.data()!;
      } else {
        // Return an empty Map or handle the case when the document doesn't exist
        return {};
      }
    } catch (e) {
      print("Error retrieving user details: $e");
      // Handle errors by returning an empty Map or another default value
      return {};
    }
  }
}
