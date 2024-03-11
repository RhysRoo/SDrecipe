// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';

// Consideration: Number of Ingredients a Recipe Should Have
// Add a food restriction
// Rating value

class AddRemoveRecipeManager {
  UserManager userManager = UserManager();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveRecipe(List<Map<String, dynamic>> ingredients,
      String recipeName, String foodRestiction) async {
    String uid = await userManager.getCurrentUserUID();

    print(ingredients);

    // Add the recipeName to each ingredient map
    List<Map<String, dynamic>> convertedList = ingredients.map((ingredient) {
      return {
        'ingredient': ingredient['ingredient'],
        'quantity': ingredient['quantity'],
      };
    }).toList();

    if (uid.isNotEmpty) {
      try {
        await firestore
            .collection("Recipes")
            .doc(uid)
            .collection(
                "UserRecipes") // Add a subcollection for user-specific recipes
            .add({
          'ingredients': convertedList,
          'recipeName': recipeName,
          'rating': "Null",
          'foodRestriction': foodRestiction,
          'createdAt': FieldValue.serverTimestamp()
        });
        print('Ingredients Stored');
        await getAllRecipes();
      } catch (e) {
        print("Error Ingredients Not Stored: $e");
      }
    }
  }

  Future<List<Map<String, dynamic>>?> getAllRecipes() async {
    String uid = await userManager.getCurrentUserUID();
    List<Map<String, dynamic>>? recipes = [];

    if (uid.isNotEmpty) {
      try {
        QuerySnapshot querySnapshot = await firestore
            .collection("Recipes")
            .doc(uid)
            .collection("UserRecipes")
            .get();

        recipes = querySnapshot.docs
            .map((doc) => doc.data())
            .cast<Map<String, dynamic>>()
            .toList();
      } catch (e) {
        print("Error fetching recipes: $e");
      }
    }
    print(recipes);
    return recipes;
  }
}
