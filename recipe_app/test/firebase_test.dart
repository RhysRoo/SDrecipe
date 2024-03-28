import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth if not already imported
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/ingredientManager.dart';

// Mock class for UserManager
class MockUserManager extends Mock implements UserManager {}

// Mock class for FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock class for FirebaseFirestore
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// Mock class for DocumentSnapshot
class MockDocumentSnapshot<T> extends Mock implements DocumentSnapshot<T> {}

void main() {
  late IngredientManager manager;
  late MockUserManager mockUserManager;
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    // Initialize mocks
    mockUserManager = MockUserManager();
    mockFirestore = MockFirebaseFirestore();
    mockFirebaseAuth = MockFirebaseAuth();

    // Initialize IngredientManager with mocked dependencies
    manager = IngredientManager();
    manager.user = mockUserManager;
    manager.firestore = mockFirestore;
  });
}
