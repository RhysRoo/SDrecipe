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

void main() {
  late IngredientManager manager;
  late MockIngredientAPI mockApi;

  setUp(() {
    // Mock API
    mockApi = MockIngredientAPI();

    // Mock FirebaseAuth and FirebaseFirestore
    final FirebaseAuth auth = MockFirebaseAuth();
    final FirebaseFirestore firestore = MockFirebaseFirestore();

    // Mock UserManager with FirebaseAuth and FirebaseFirestore mocks
    final UserManager userManager =
        UserManager(auth: auth, firestore: firestore);

    // Initialize IngredientManager with the mocked UserManager and API
    manager = IngredientManager();
    manager.user = userManager;
    manager.api = mockApi;
  });

  group('validateQuantity', () {
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

  group('convertStringtoDatetime', () {
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

  group('checkDateTimeAgainstTodaysDate', () {
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

  group('checkUserDateTime', () {
    test('checkUserDateTime returns true for valid date after today', () {
      // Arrange
      final manager = IngredientManager();
      const validDateString =
          '2024-03-31'; // Change to a valid date string after today

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
