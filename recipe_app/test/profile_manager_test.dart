import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_log/pages/profile_page/profileManager.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_log/pages/profile_page/userModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserManager extends Mock implements UserManager {}

void main() {
  late ProfileManager profileManager;
  late FirebaseFirestore fakeFirestore;
  late MockFirebaseAuth mockAuth;

  setUp(() {
    // Mock FirebaseAuth and FirebaseFirestore
    fakeFirestore = FakeFirebaseFirestore();
    mockAuth = MockFirebaseAuth();

    // Profile Manager with Mocked Dependencies
    profileManager = ProfileManager(auth: mockAuth, firestore: fakeFirestore);
    profileManager.userManager =
        MockUserManager(); // Assuming you have a MockUserManager class
  });

  group('Profile Manager checkInputLength() Tests', () {
    test('Less than exceeded value therefore return true', () {
      bool result = profileManager.checkInputLength('This is an Example Bio');
      expect(result, true); // Assert the expected result
    });

    test('Less than exceeded value therefore return true', () {
      bool result = profileManager
          .checkInputLength('This is an Example Bio: This is a bit longer');
      expect(result, true); // Assert the expected result
    });

    test('More than exceeded value therefore return true', () {
      bool result = profileManager.checkInputLength(
          'John Smith is an intrepid explorer of the human condition, traversing the landscapes of literature, science, and philosophy with equal fervor. With a penchant for unraveling the mysteries of existence, he delves into the depths of the written word, seeking to illuminate the complexities of life. As an avid reader and thinker, he navigates the intricacies of the human psyche, weaving together the threads of thought to craft profound insights into the tapestry of existence. With a heart ablaze with curiosity and a mind as vast as the cosmos, John ventures forth into the realms of knowledge, driven by an insatiable thirst for understanding.');
      expect(result, false); // Assert the expected result
    });

    test('Less than exceeded value therefore return true', () {
      bool result = profileManager.checkInputLength('');
      expect(result, true); // Assert the expected result
    });
  });
}
