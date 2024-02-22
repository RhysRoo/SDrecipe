// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_log/pages/profile_page/userModel.dart';

class ProfileManager {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final UserManager userManager = UserManager();

  Future<void> storeUserDetails(UserModel user) async {
    try {
      String? uid = await userManager.getCurrentUserUID();
      await firestore.collection("UserDetails").doc(uid).set(user.toJson());
      print('User details stored successfully');
    } catch (e) {
      print("Error storing user details: $e");
    }
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    try {
      String? uid = await userManager.getCurrentUserUID();
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firestore.collection("UserDetails").doc(uid).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print("Error retrieving user details: $e");
    }
    return null;
  }
}
