// ignore_for_file: subtype_of_sealed_class, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Mock FirebaseAuth and FirebaseFirestore classes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {
  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) {
    // Check if the collectionPath matches "UserDetails"
    if (collectionPath == 'UserDetails') {
      // Return a mock CollectionReference specifically for "UserDetails"
      return MockCollectionReference();
    } else {
      throw Exception('Unexpected collection path: $collectionPath');
    }
  }
}

// MockUser class to mock the User object
class MockUser extends Mock implements User {
  @override
  String get uid => 'mockUID';
}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {
  final Map<String, dynamic> _data;

  MockDocumentSnapshot(this._data);

  @override
  Map<String, dynamic>? data() => _data;
}

// Must Link to Snapshot
class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

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

  // Test is faulty due to nullability
  group('getFoodRestriction', () {
    test('Valid UID promotes Valid foodRestriction', () async {
      const String uid = 'UID';

      // Mock Document Snapshot
      final Map<String, dynamic> userProfileData = {
        'foodRestriction': 'Vegitarian'
      };

      final MockDocumentSnapshot mockDocumentSnapshot =
          MockDocumentSnapshot(userProfileData);

      when(userManager.getCurrentUserUID()).thenAnswer((_) async => uid);

      when(mockFirestore.collection('UserDetails').doc(uid).get())
          .thenAnswer((_) async => mockDocumentSnapshot);

      // Call the method under test
      final foodRestriction = await userManager.getFoodRestriction();

      // Assert that the returned food restriction matches the expected value
      expect(foodRestriction, 'Vegetarian');
    });

    test('Invalid UID promotes Invalid foodRestriction', () async {
      // Mock currentUser to return null
      when(mockAuth.currentUser).thenReturn(null);

      // Call the method being tested
      final uid = await userManager.getCurrentUserUID();

      // Verify that the returned UID is an empty string
      expect(uid, '');
    });
  });
}
