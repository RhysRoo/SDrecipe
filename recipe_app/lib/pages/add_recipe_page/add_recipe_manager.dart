// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';

// Consideration: Number of Ingredients a Recipe Should Have

class AddRemoveRecipeManager {
  UserManager userManager = UserManager();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveRecipe(  // Bug Storing the ingredients [Recipe Name, {ingredientName, quantity, ingredient Name, quantity}]
      List<Map<String, dynamic>> ingredients, String recipeName) async {
    String uid = await userManager.getCurrentUserUID();

    print(ingredients);

    // Add the recipeName to each ingredient map
    List<Map<String, dynamic>> convertedList = ingredients.map((ingredient) {
      return {
        'ingredientName': ingredient['ingredientName'],
        'quantity': ingredient['quantity'],
        'recipeName': recipeName,
      };
    }).toList();

    print(convertedList);

    if (uid.isNotEmpty) {
      try {
        await firestore
            .collection("UserIngredients")
            .doc(uid)
            .set({'ingredients': convertedList});
        print('Ingredients Stored');
      } catch (e) {
        print("Error Ingredients Not Stored: $e");
      }
    }
  }
}
