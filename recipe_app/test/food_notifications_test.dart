// Mock class for UserManager
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/ingredientManager.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/open_food_api.dart';
import 'package:flutter_log/pages/home_page/food_notifications/notifications.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock class for Ingredients Manager
class MockUserManager extends Mock implements UserManager {}

// Mock class for FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock class for IngredientAPI
class MockIngredientAPI extends Mock implements IngredientAPI {}

void main() {
  late IngredientManager ingredient_manager;
  late MockIngredientAPI mockApi;
  late FirebaseFirestore fakeFirestore;
  late MockFirebaseAuth mockAuth;
  late NotificationManager notificationManager;

  setUp(() {
    // Mock API
    mockApi = MockIngredientAPI();

    // Mock FirebaseAuth and FirebaseFirestore
    fakeFirestore = FakeFirebaseFirestore();
    mockAuth = MockFirebaseAuth();

    // Mock UserManager with FirebaseAuth and FirebaseFirestore mocks
    final UserManager userManager =
        UserManager(auth: mockAuth, firestore: fakeFirestore);

    // Initialize IngredientManager with the mocked UserManager and API
    ingredient_manager = IngredientManager();
    ingredient_manager.user = userManager;
    ingredient_manager.api = mockApi;
    ingredient_manager.firestore = fakeFirestore;

    // Initialise Notification Manager with the mocked Ingredient Manager
    notificationManager = NotificationManager();
    notificationManager.ingredientManager = ingredient_manager;
  });

  group('Notifications Manager: removeExpiredIngredientsAndNotify() Test', () {
    test(
        'Expired ingredient firestore should return map of expired ingredients [{}]',
        () async {
      // Arrange
      fakeFirestore.collection('UserIngredients').doc('dummyUid').set({
        'ingredients': [
          {
            'name': 'Lemon',
            'weight': '30',
            'expiryDate': '2021-07-03',
          }
        ]
      });
      // Mock the current user
      when(mockAuth.currentUser).thenReturn(MockUser(uid: 'dummyUid'));

      // Act
      final removedIngredients =
          await notificationManager.removeExpiredIngredientsAndNotify();

      // Assert

      expect(removedIngredients.length, 1);

      // Assert that the first removed ingredient has the expected name and expiry date
      expect(removedIngredients[0]['name'], 'Lemon');
      expect(removedIngredients[0]['expiryDate'], '2021-07-03');
    });

    test(
        'Expired and Unexpired ingredient firestore should return map of expired ingredients [{}]',
        () async {
      // Arrange
      fakeFirestore.collection('UserIngredients').doc('dummyUid').set({
        'ingredients': [
          {
            'name': 'Lemon',
            'weight': '30',
            'expiryDate': '2021-07-03',
          },
          {
            'name': 'Melon',
            'weight': '30',
            'expiryDate': '2025-07-03',
          },
        ]
      });
      // Mock the current user
      when(mockAuth.currentUser).thenReturn(MockUser(uid: 'dummyUid'));

      // Act
      final removedIngredients =
          await notificationManager.removeExpiredIngredientsAndNotify();

      // Assert

      expect(removedIngredients.length, 1);

      expect(removedIngredients, [
        {"name": "Lemon", "expiryDate": "2021-07-03"}
      ]);
    });

    test(
        'Expired and Unexpired ingredient firestore should return map of expired ingredients [{}]',
        () async {
      // Arrange
      fakeFirestore.collection('UserIngredients').doc('dummyUid').set({
        'ingredients': [
          {
            'name': 'Lemon',
            'weight': '30',
            'expiryDate': '2021-07-03',
          },
          {
            'name': 'Melon',
            'weight': '30',
            'expiryDate': '2025-07-03',
          },
          {
            'name': 'Carrot',
            'weight': '30',
            'expiryDate': '2022-01-03',
          },
          {
            'name': 'Peach',
            'weight': '30',
            'expiryDate': '2023-01-03',
          },
        ]
      });
      // Mock the current user
      when(mockAuth.currentUser).thenReturn(MockUser(uid: 'dummyUid'));

      // Act
      final removedIngredients =
          await notificationManager.removeExpiredIngredientsAndNotify();

      // Assert

      expect(removedIngredients.length, 3);

      expect(removedIngredients, [
        {"name": "Lemon", "expiryDate": "2021-07-03"},
        {"name": "Carrot", "expiryDate": "2022-01-03"},
        {"name": "Peach", "expiryDate": "2023-01-03"},
      ]);
    });
    test('Null UID / Unauthorised should return []', () async {
      // Arrange
      fakeFirestore.collection('UserIngredients').doc(null).set({
        'ingredients': [
          {
            'name': 'Lemon',
            'weight': '30',
            'expiryDate': '2021-07-03',
          },
          {
            'name': 'Melon',
            'weight': '30',
            'expiryDate': '2025-07-03',
          },
          {
            'name': 'Carrot',
            'weight': '30',
            'expiryDate': '2022-01-03',
          },
          {
            'name': 'Peach',
            'weight': '30',
            'expiryDate': '2023-01-03',
          },
        ]
      });
      // Mock the current user
      when(mockAuth.currentUser).thenReturn(null);

      // Act
      final removedIngredients =
          await notificationManager.removeExpiredIngredientsAndNotify();

      // Assert

      expect(removedIngredients.length, 0);

      expect(removedIngredients, []);
    });

    test('No firestore should return []', () async {
      // Mock the current user
      when(mockAuth.currentUser).thenReturn(MockUser(uid: "dummyUid"));

      // Act
      final removedIngredients =
          await notificationManager.removeExpiredIngredientsAndNotify();

      // Assert

      expect(removedIngredients.length, 0);

      expect(removedIngredients, []);
    });
  });
}
