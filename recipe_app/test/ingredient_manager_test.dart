import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/ingredientManager.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/open_food_api.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock class for UserManager
class MockUserManager extends Mock implements UserManager {}

// Mock class for FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock class for IngredientAPI
class MockIngredientAPI extends Mock implements IngredientAPI {}

void main() {
  late IngredientManager manager;
  late MockIngredientAPI mockApi;
  late FirebaseFirestore fakeFirestore;
  late MockFirebaseAuth mockAuth;

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
    manager = IngredientManager();
    manager.user = userManager;
    manager.api = mockApi;
    manager.firestore = fakeFirestore;
  });

  group('Ingredient Manager: storeUserIngredients() Test', () {
    // Prepare more testing examples
    test('Store User Ingredients', () async {
      // Prepare test data
      List<List<String>> listIngredients = [
        ["Lemon", "30", "2024-07-03"],
        // Add more ingredients as needed
      ];

      // Mock the current user
      when(mockAuth.currentUser).thenReturn(MockUser(uid: 'dummyUid'));

      // Invoke the method
      await manager.storeUserIngredients(listIngredients);

      // Verify the result
      final storedDocument = await fakeFirestore
          .collection('UserIngredients')
          .doc('dummyUid')
          .get();
      final storedIngredients = storedDocument.data()?['ingredients'];

      print(storedIngredients);

      expect(storedIngredients, [
        {"name": "Lemon", "weight": "30", "expiryDate": "2024-07-03"},
        // Add more expected ingredients as needed
      ]);
    });

    test('Null UID should return null', () async {
      // Prepare test data
      List<List<String>> listIngredients = [
        ["Lemon", "30", "2024-07-03"], ["Melon", "30", "2024-07-01"],
        // Add more ingredients as needed
      ];

      // Mock the current user
      when(mockAuth.currentUser).thenReturn(null);

      // Invoke the method
      await manager.storeUserIngredients(listIngredients);

      // Verify the result
      final storedDocument =
          await fakeFirestore.collection('UserIngredients').doc(null).get();
      final storedIngredients = storedDocument.data()?['ingredients'];

      expect(storedIngredients, null);
    });

    test('Incorrect listIngredients should return null', () async {
      // Mock the current user
      when(mockAuth.currentUser).thenReturn(MockUser(uid: "dummyUid"));

      // Invoke the method
      await manager.storeUserIngredients([]);

      // Verify the result
      final storedDocument =
          await fakeFirestore.collection('UserIngredients').doc(null).get();
      final storedIngredients = storedDocument.data()?['ingredients'];

      expect(storedIngredients, null);
    });

    test('Store User Ingredients', () async {
      // Prepare test data
      List<List<String>> listIngredients = [
        ["Lemon", "30", "2024-07-03"], ["Melon", "30", "2024-07-01"],
        // Add more ingredients as needed
      ];

      // Mock the current user
      when(mockAuth.currentUser).thenReturn(MockUser(uid: 'dummyUid'));

      // Invoke the method
      await manager.storeUserIngredients(listIngredients);

      // Verify the result
      final storedDocument = await fakeFirestore
          .collection('UserIngredients')
          .doc('dummyUid')
          .get();

      final storedIngredients = storedDocument.data()?['ingredients'];

      expect(storedIngredients, [
        {"name": "Lemon", "weight": "30", "expiryDate": "2024-07-03"},
        {"name": "Melon", "weight": "30", "expiryDate": "2024-07-01"}
        // Add more expected ingredients as needed
      ]);
    });
  });

  group('Ingredient Manager: getIngredients() Test', () {
    test('Valid Collection Retrieval', () async {
      // Set up the fake Firestore document with the expected data
      fakeFirestore.collection('UserIngredients').doc('dummyUid').set({
        'ingredients': [
          {
            'name': 'Lemon',
            'weight': '30',
            'expiryDate': '2024-07-03',
          }
        ]
      });

      // Mock the current user
      when(mockAuth.currentUser).thenReturn(MockUser(uid: 'dummyUid'));

      // Call the method under test
      List<List<String>> result = await manager.getUserIngredients();

      // Verify the result
      expect(result, [
        ['Lemon', '30', '2024-07-03']
      ]);
    });

    test('Longer Valid Collection Retrieval', () async {
      // Set up the fake Firestore document with the expected data
      fakeFirestore.collection('UserIngredients').doc('dummyUid').set({
        'ingredients': [
          {
            'name': 'Lemon',
            'weight': '30',
            'expiryDate': '2024-06-03',
          },
          {
            'name': 'Melon',
            'weight': '30',
            'expiryDate': '2024-07-01',
          }
        ]
      });

      // Mock the current user
      when(mockAuth.currentUser).thenReturn(MockUser(uid: 'dummyUid'));

      // Call the method under test
      List<List<String>> result = await manager.getUserIngredients();

      // Verify the result
      expect(result, [
        ['Lemon', '30', '2024-06-03'],
        ['Melon', '30', '2024-07-01']
      ]);
    });

    test('Invalid UID Retrieval should return []', () async {
      fakeFirestore.collection('UserIngredients').doc('dummyUid').set({
        'ingredients': [
          {"name": "Lemon", "weight": "30", "expiryDate": "2024-07-03"}
        ],
      });

      when(manager.user.getCurrentUserUID()).thenAnswer((_) async => '');

      List<List<String>> result = await manager.getUserIngredients();

      expect(result, []);
    });

    test('Null UID Retrieval should return []', () async {
      fakeFirestore.collection('UserIngredients').doc(null).set({
        'ingredients': [
          {"name": "Lemon", "weight": "30", "expiryDate": "2024-07-03"}
        ],
      });

      when(manager.user.getCurrentUserUID()).thenAnswer((_) async => '');

      List<List<String>> result = await manager.getUserIngredients();

      expect(result, []);
    });

    test('No Collection Documentation should return []', () async {
      when(manager.user.getCurrentUserUID()).thenAnswer((_) async => '');

      List<List<String>> result = await manager.getUserIngredients();

      expect(result, []);
    });
  });

  group('Ingredient Manager: validateQuantity() Test', () {
    test('returns true for quantity >= 10 grams', () {
      // Arrange
      const validQuantity = '15';

      // Act
      final result = manager.validateQuantity(validQuantity);

      // Assert
      expect(result, true);
    });

    test('returns false for quantity < 10 grams', () {
      // Arrange
      const invalidQuantity = '5';

      // Act
      final result = manager.validateQuantity(invalidQuantity);

      // Assert
      expect(result, false);
    });
  });

  group('Ingredient Manager: convertStringtoDatetime() Test', () {
    test(
        'convertStringtoDatetime returns correct DateTime for valid date string',
        () {
      // Arrange
      final manager = IngredientManager();
      const validDateString = '2024-03-31'; // Change to a valid date string

      // Act
      final result = manager.convertStringtoDatetime(validDateString);

      // Assert
      expect(result, isA<DateTime>());
      expect(result.year, equals(2024));
      expect(result.month, equals(3));
      expect(result.day, equals(31));
    });

    test('convertStringtoDatetime throws ArgumentError for invalid date string',
        () {
      // Arrange
      final manager = IngredientManager();
      const invalidDateString =
          'Invalid Date'; // Change to an invalid date string

      // Act & Assert
      expect(() => manager.convertStringtoDatetime(invalidDateString),
          throwsArgumentError);
    });

    test('convertStringtoDatetime throws ArgumentError for empty date string',
        () {
      // Arrange
      final manager = IngredientManager();
      const emptyDateString = ''; // Empty date string

      // Act & Assert
      expect(() => manager.convertStringtoDatetime(emptyDateString),
          throwsArgumentError);
    });
  });

  group('Ingredient Manager: checkDateTimeAgainstTodaysDate() Test', () {
    test(
        'checkDateTimeAgainstTodaysDate returns true for valid date before today',
        () {
      // Arrange
      final manager = IngredientManager();
      const validDateString =
          '2024-03-31'; // Change to a valid date string before today

      // Act
      final result = manager.checkDateTimeAgainstTodaysDate(validDateString);

      // Assert
      expect(result, isTrue);
    });

    test(
        'checkDateTimeAgainstTodaysDate returns true for valid date after today',
        () {
      // Arrange
      final manager = IngredientManager();
      const validDateString =
          '2024-04-02'; // Change to a valid date string after today

      // Act
      final result = manager.checkDateTimeAgainstTodaysDate(validDateString);

      // Assert
      expect(result, isTrue);
    });

    test('checkDateTimeAgainstTodaysDate returns false for invalid date string',
        () {
      // Arrange
      final manager = IngredientManager();
      const invalidDateString =
          'Invalid Date'; // Change to an invalid date string

      // Act
      final result = manager.checkDateTimeAgainstTodaysDate(invalidDateString);

      // Assert
      expect(result, isFalse);
    });

    test('checkDateTimeAgainstTodaysDate returns false for empty date string',
        () {
      // Arrange
      final manager = IngredientManager();
      const emptyDateString = ''; // Empty date string

      // Act
      final result = manager.checkDateTimeAgainstTodaysDate(emptyDateString);

      // Assert
      expect(result, isFalse);
    });
  });

  group('Ingredient Manager: checkUserDateTime() Test', () {
    test('checkUserDateTime returns true for valid date after today', () {
      // Arrange
      final manager = IngredientManager();
      const validDateString =
          '2024-08-31'; // Change to a valid date string after today

      // Act
      final result = manager.checkUserDateTime(validDateString);

      // Assert
      expect(result, isTrue);
    });

    test(
        'checkUserDateTime returns false for valid date before today (Formatting)',
        () {
      // Arrange
      final manager = IngredientManager();
      const validDateString =
          '2024-02-02'; // Change to a valid date string before today

      // Act
      final result = manager.checkUserDateTime(validDateString);

      // Assert
      expect(result, isFalse);
    });

    test('checkUserDateTime returns false for invalid date string', () {
      // Arrange
      final manager = IngredientManager();
      const invalidDateString =
          'Invalid Date'; // Change to an invalid date string

      // Act
      final result = manager.checkUserDateTime(invalidDateString);

      // Assert
      expect(result, isFalse);
    });

    test('checkUserDateTime returns false for empty date string', () {
      // Arrange
      final manager = IngredientManager();
      const emptyDateString = ''; // Empty date string

      // Act
      final result = manager.checkUserDateTime(emptyDateString);

      // Assert
      expect(result, isFalse);
    });
  });
}