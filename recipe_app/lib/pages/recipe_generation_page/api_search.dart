// recipe_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_log/pages/add_remove_ingredients_page/ingredientManager.dart';
import 'recipe.dart';

class RecipeService {
  final IngredientManager ingredientManager = IngredientManager();

  List<Recipe> filteredRecipes(List<String> ingredientNames, List<Recipe> recipes) {
    List<Recipe> filteredRecipes = [];
    for (Recipe recipe in recipes) {
      List<String> recipeIngredients = recipe.ingredients.map((ingredient) => ingredient.food).toList();
      List<String> missingIngredients = ingredientNames.where((ingredient) => !recipeIngredients.contains(ingredient)).toList();
      if (missingIngredients.isEmpty) {
        filteredRecipes.add(recipe);
      }
    }
    return filteredRecipes;
  }

  Future<List<Recipe>> fetchRecipesBasedOnUserIngredients() async {
    // Retrieve the user's ingredients
    List<List<String>> userIngredients = await ingredientManager.getUserIngredients();
    // Extract the names of the ingredients
    List<String> ingredientNames = userIngredients.map((ingredient) => ingredient.first).toList();
    //get recipes from API with ingredients in
    List<dynamic> recipesJson = await fetchRecipes(ingredientNames);
    //parse JSON data into Recipe objects
    List<Recipe> recipes = recipesJson.map((recipeJson) => Recipe.fromJson(recipeJson['recipe'])).toList();
    // filter recipes to only include those with ingredients in ingredientNames
    List<Recipe> filtered = filteredRecipes(ingredientNames, recipes);
    return filtered;
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
