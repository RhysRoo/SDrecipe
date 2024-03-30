import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_log/pages/profile_page/profileManager.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock class for FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserManager extends Mock implements UserManager {}

// Issues with mocking the firestore
void main() {
  late ProfileManager profileManager;
  late MockFirebaseAuth mockAuth;
  late FirebaseFirestore mockFirestore;

  setUp(() {
    // Create mock instances of dependencies
    mockFirestore = FakeFirebaseFirestore();
    mockAuth = MockFirebaseAuth();

    // Inject mock dependencies into UserManager
    final UserManager userManager =
        UserManager(auth: mockAuth, firestore: mockFirestore);

    // Inject mock dependencies into ProfileManager
    profileManager = ProfileManager();
    profileManager.firestore = mockFirestore;
    profileManager.userManager = userManager;
  });

  test('testing test', () {
    expect(true, true);
  });
}
