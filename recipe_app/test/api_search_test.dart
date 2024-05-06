import 'package:flutter_log/pages/add_remove_ingredients_page/ingredientManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_log/pages/recipe_generation_page/api_search.dart';
import 'dart:convert';

class MockClient extends Mock implements http.Client {}
class MockIngredientManager extends Mock implements IngredientManager {}

void main() {
  group('RecipeService', () {
    late MockClient client;
    late MockIngredientManager ingredientManager;
    late RecipeService recipeService;

    setUp(() {
      client = MockClient();
      ingredientManager = MockIngredientManager();
      recipeService = RecipeService(client: client, ingredientManager: ingredientManager);
    });

    test('fetchRecipesBasedOnUserIngredients returns empty list if no ingredients', () async {
      when(ingredientManager.getUserIngredients()).thenAnswer((_) async => []);

      var result = await recipeService.fetchRecipesBasedOnUserIngredients();

      expect(result, isEmpty);
    });

    test('fetchRecipesBasedOnUserIngredients returns recipes when ingredients are provided', () async {
      when(ingredientManager.getUserIngredients()).thenAnswer((_) async => [['Tomato'], ['Onion']]);
      when(client.get(any as Uri)).thenAnswer((_) async => http.Response(jsonEncode({
        'hits': [
          {'recipe': {'label': 'Tomato Soup', 'url': 'http://example.com', 'image': 'http://example.com/image.jpg'}}
        ]
      }), 200));

      var result = await recipeService.fetchRecipesBasedOnUserIngredients();

      expect(result.length, 1);
      expect(result[0]['recipe']['label'], 'Tomato Soup');
    });
  });
}