import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FirebaseFirestore fakeFirestore;
  late MockFirebaseAuth mockAuth;
  late UserManager userManager;

  setUp(() {
    // Mock FirebaseAuth and FirebaseFirestore
    fakeFirestore = FakeFirebaseFirestore();
    mockAuth = MockFirebaseAuth();

    // Mock UserManager with FirebaseAuth and FirebaseFirestore mocks
    final UserManager userManager =
        UserManager(auth: mockAuth, firestore: fakeFirestore);
  });

  
}
