import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/ingredientManager.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/open_food_api.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock class for UserManager
class MockUserManager extends Mock implements UserManager {}

// Mock class for FirebaseFirestore
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// Mock class for FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock class for IngredientAPI
class MockIngredientAPI extends Mock implements IngredientAPI {}

// Mock class for DocumentSnapshot
class MockDocumentSnapshot<T> extends Mock implements DocumentSnapshot<T> {
  final T _mockData;

  MockDocumentSnapshot(this._mockData);

  T get mockData => _mockData;
}

void main() {
  late IngredientManager manager;
  late MockUserManager mockUserManager;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    // Mock dependencies
    mockUserManager = MockUserManager();
    mockFirestore = MockFirebaseFirestore();

    // Initialize IngredientManager with mocked dependencies
    manager = IngredientManager();
    manager.user = mockUserManager;
    manager.firestore = mockFirestore;
  });

  test('getUserIngredients returns correct data when document exists',
      () async {
    // Arrange
    const uid = 'user123';
    const ingredientData = {
      'ingredients': [
        {'name': 'Ingredient1', 'weight': '100', 'expiryDate': '2024-04-01'},
        {'name': 'Ingredient2', 'weight': '200', 'expiryDate': '2024-04-02'}
      ]
    };

    when(mockUserManager.getCurrentUserUID()).thenAnswer((_) async => uid);
    when(mockFirestore.collection("UserIngredients").doc(uid).get()).thenAnswer(
        (_) async =>
            MockDocumentSnapshot<Map<String, dynamic>>(ingredientData));

    // Act
    final result = await manager.getUserIngredients();

    // Assert
    expect(result, [
      ['Ingredient1', '100', '2024-04-01'],
      ['Ingredient2', '200', '2024-04-02']
    ]);
  });

  // Add more test cases for other scenarios...
}
