// recipe_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_log/pages/add_remove_ingredients_page/ingredientManager.dart';

class RecipeService {
  final IngredientManager ingredienManager = IngredientManager();

  Future<List<dynamic>> fetchRecipesBasedOnUserIngredients() async {
    // Retrieve the user's ingredients
    List<List<String>> userIngredients = await ingredienManager.getUserIngredients();
    // Extract the names of the ingredients
    List<String> ingredientNames = userIngredients.map((ingredient) => ingredient.first).toList();

    // Fetch recipes using these ingredient names
    return fetchRecipes(ingredientNames);
  }

  Future<List<dynamic>> fetchRecipes(List<String> ingredients) async {
    const String apiId = 'YOUR_API_ID';
    const String apiKey = 'YOUR_API_KEY';

    String ingredientQuery = ingredients.join(',');

    String url = 'https://api.edamam.com/search?app_id=$apiId&app_key=$apiKey&q=$ingredientQuery&to=10';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> recipes = data['hits'];
        return recipes;
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
