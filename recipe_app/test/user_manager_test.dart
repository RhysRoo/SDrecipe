// ignore_for_file: subtype_of_sealed_class, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock FirebaseAuth and FirebaseFirestore classes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late UserManager userManager;
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    // Initialize mocks
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();

    // Initialize UserManager with mocked dependencies
    userManager = UserManager(auth: mockAuth, firestore: mockFirestore);
  });

  group('getCurrentUserUID', () {
    test('getCurrentUserUID returns UID when user is not null', () async {
      // Mock currentUser to return a user with UID 'mockUID'
      when(mockAuth.currentUser).thenReturn(MockUser());

      // Call the method being tested
      final uid = await userManager.getCurrentUserUID();

      // Verify that the returned UID matches the expected value
      expect(uid, 'mockUID');
    });

    test('getCurrentUserUID returns empty string when user is null', () async {
      // Mock currentUser to return null
      when(mockAuth.currentUser).thenReturn(null);

      // Call the method being tested
      final uid = await userManager.getCurrentUserUID();

      // Verify that the returned UID is an empty string
      expect(uid, '');
    });
  });

  // ############### getFoodRestriction Test ###############
}

// MockCollectionReference class to mock the CollectionReference object
class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

// MockUser class to mock the User object
class MockUser extends Mock implements User {
  @override
  String get uid => 'mockUID';
}

// MockDocumentSnapshot class to mock the DocumentSnapshot object
class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {
  final Map<String, dynamic> _data;

  MockDocumentSnapshot(this._data);

  @override
  Map<String, dynamic> data() => _data;
}
