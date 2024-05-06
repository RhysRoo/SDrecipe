// recipe_service.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:js_interop';
import 'package:http/http.dart' as http;
import 'package:flutter_log/pages/add_remove_ingredients_page/ingredientManager.dart';
import 'recipe.dart';

class RecipeService {
  final http.Client client;
  final IngredientManager ingredientManager;

  RecipeService({http.Client? client, IngredientManager? ingredientManager})
      : this.client = client ?? http.Client(),
        this.ingredientManager = ingredientManager ?? IngredientManager();

  // List<Recipe> filteredRecipes(List<String> ingredientNames, List<Recipe> recipes) {
  //   List<Recipe> filteredRecipes = [];
  //   for (Recipe recipe in recipes) {
  //     List<String> recipeIngredients = recipe.ingredients.map((ingredient) => ingredient.food).toList();
  //     List<String> missingIngredients = ingredientNames.where((ingredient) => !recipeIngredients.contains(ingredient)).toList();
  //     if (missingIngredients.isEmpty) {
  //       filteredRecipes.add(recipe);
  //     }
  //     filteredRecipes.add(recipe);
  //   }
  //   return filteredRecipes;
  // }

  Future<List<dynamic>> fetchRecipesBasedOnUserIngredients() async {
    // Retrieve the user's ingredients
    List<List<String>> userIngredients = await ingredientManager.getUserIngredients();
    if (userIngredients.length <= 0) {
      //error handling for no ingredients.
      return[];
    }
    // Extract the names of the ingredients
    List<String> ingredientNames = userIngredients.map((ingredient) => ingredient.first).toList();
    //get recipes from API with ingredients in
    List<dynamic> recipesJson = await fetchRecipes(ingredientNames);
    //parse JSON data into Recipe objects
    //List<Recipe> recipes = recipesJson.map((recipeJson) => Recipe.fromJson(recipeJson['recipe'])).toList();
    // filter recipes to only include those with ingredients in ingredientNames
    //List<Recipe> filtered = filteredRecipes(ingredientNames, recipes);
    return recipesJson.take(5).toList();
  }

  Future<List<dynamic>> fetchRecipes(List<String> ingredients) async {
    const String apiId = '87adcf60';
    const String apiKey = 'APIKEY';

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

  Future<List<String>> getRecipeNames() async {
    List<dynamic> recipes = await fetchRecipesBasedOnUserIngredients();
    List<String> labels = [];

    for (int i = 0; i < recipes.length && i < 5; i++) {
      Map<String, dynamic> recipe = recipes[i]['recipe'];
      labels.add(recipe['label']);
    }
    return labels;
  }

  Future<List<String>> getRecipeUrls() async {
    List<dynamic> recipes = await fetchRecipesBasedOnUserIngredients();
    List<String> urls = [];

    for (int i = 0; i < recipes.length && i < 5; i++) {
      Map<String, dynamic> recipe = recipes[i]['recipe'];
      urls.add(recipe['url']);
    }
    return urls;
  }

  Future<List<String>> getRecipeImage() async {
    List<dynamic> recipes = await fetchRecipesBasedOnUserIngredients();
    List<String> images = [];

    for (int i = 0; i < recipes.length && i < 5; i++) {
      Map<String, dynamic> recipe = recipes[i]['recipe'];
      images.add(recipe['image']);
    }
    return images;
  }
}
