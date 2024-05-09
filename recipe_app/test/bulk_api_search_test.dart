import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/ingredientManager.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/open_food_api.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';
import 'package:flutter_log/pages/recipe_generation_page/api_search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}
class MockIngredientManager extends Mock implements IngredientManager {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserManager extends Mock implements UserManager {}
class MockIngredientAPI extends Mock implements IngredientAPI {}

void main() {
  group('RecipeService', () {
    late MockClient client;
    late IngredientManager ingredientManager;
    late RecipeService recipeService;
    late FirebaseFirestore fakeFirestore;
    late MockFirebaseAuth mockAuth;
    late MockIngredientAPI mockApi;
    late MockUser mockUser;

    Future<void> setupServices() async {
      mockApi = MockIngredientAPI();

      fakeFirestore = FakeFirebaseFirestore();
      mockAuth = MockFirebaseAuth();
      mockUser = MockUser();

      final UserManager userManager =
      UserManager(auth: mockAuth, firestore: fakeFirestore);

      ingredientManager =
          IngredientManager(auth: mockAuth, firestore: fakeFirestore);
      ingredientManager.userManager = userManager;
      ingredientManager.api = mockApi;
      ingredientManager.firestore = fakeFirestore;

      when(mockAuth.currentUser).thenReturn(mockUser);

      client = MockClient();
      recipeService = RecipeService(client: client, ingredientManager: ingredientManager);
    }

    setUp(setupServices);

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 1', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Pasta'], ['Onion']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 2', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Tomato'], ['Pasta']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 3', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Pasta'], ['Cheddar']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 4', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Rice'], ['Cheddar']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 5', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Cheddar'], ['Onion']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 6', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Tomato'], ['Rice']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 7', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Tomato']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 8', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Onion']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 9', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Tomato'], ['Onion'], ['Cheddar'], ['Pasta']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 10', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Rice'], ['Pasta']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 11', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Tomato'], ['Cucumber']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 12', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Tomato'], ['Orange']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 13', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Orange'], ['Pasta']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 14', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Cheddar'], ['Raisins']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 15', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Apple'], ['Raisins']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided 16', () async {
      when(ingredientManager.userManager.getCurrentUserUID()).thenAnswer((_) => Future.value('TestUid'));
      when(ingredientManager.getUserIngredients()).thenAnswer((_) => Future.value([['Peas'], ['Pasta']]));

      final List<dynamic> result = await recipeService.fetchRecipesBasedOnUserIngredients();
      print(result.toString());
      expect(result.length, 5);
      expect(result[0]['recipe']['label'], isA<String>());
      expect(result[0]['recipe']['label'], isNotEmpty);
      expect(result[0]['recipe']['url'], isA<String>());
      expect(result[0]['recipe']['url'], isNotEmpty);
      expect(result[0]['recipe']['url'], matches(RegExp(r'^https?://.+')));
    });
  });
}