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

  // Mocking Complete Just Testing
  test('Test removing expired ingredients and notification', () async {
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

    List<List<String>> result = await ingredient_manager.getUserIngredients();

    Future.delayed(const Duration(seconds: 2));

    // Act
    final removedIngredients =
        await notificationManager.removeExpiredIngredientsAndNotify();

    // Act
    expect(removedIngredients, []);
  });
}
