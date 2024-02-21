// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/open_food_api.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';

// DO NOT TOUCH THIS CODE, THANK YOU VERY MUCH

class IngredientManager {
  IngredientAPI api = IngredientAPI();
  UserManager user = UserManager();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<List<String>>> getUserIngredients() async {
    String uid = await user.getCurrentUserUID();
    List<List<String>> result = [];

    if (uid.isNotEmpty) {
      try {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await firestore.collection("UserIngredients").doc(uid).get();

        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data() ?? {};
          List<Map<String, dynamic>> ingredientsData =
              List<Map<String, dynamic>>.from(data['ingredients'] ?? []);

          result = ingredientsData.map((ingredient) {
            // Converts from Firebase JSON Format into Original
            return [
              ingredient['name']?.toString() ?? '',
              ingredient['weight']?.toString() ?? '',
            ];
          }).toList();

          return result;
        } else {
          print("No previous data");
        }
      } catch (e) {
        print("Error retrieving user details: $e");
      }
    }
    return result;
  }

  Future<void> flushUserIngredients(List<List<String>> listIngredients) async {
    // The Linker between getting previous data and submitting new data
    await _storeUserIngredients(listIngredients);
  }

  Future<void> _storeUserIngredients(List<List<String>> listIngredients) async {
    String uid = await user.getCurrentUserUID();
    print(listIngredients);

    List<Map<String, dynamic>> convertedList = // Conversion into a JSON Format
        listIngredients.map((ingredient) {
      return {
        'name': ingredient[0],
        'weight': ingredient[1],
      };
    }).toList();

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

  bool validateQuantity(String quantity) {
    try {
      // Attempt to parse the quantity as a double
      double numericQuantity = double.parse(quantity);

      // Check if the quantity is greater than or equal to 10 grams
      if (numericQuantity < 10) {
        print('Quantity must be at least 10 grams.');
        return false;
      }

      // Additional checks based on your requirements can be added here

      return true; // All checks passed
    } catch (e) {
      print('Invalid quantity format.');
      return false; // Quantity couldn't be parsed as a double
    }
  }

  Future<bool> checkIngredientIsValid(
      String ingredientName, String ingredientWeight) async {
    // Validate ingredientName
    if (ingredientName.isEmpty || ingredientWeight.isEmpty) {
      return false;
    }

    // Check if the ingredientName contains any numbers
    if (RegExp(r'\d').hasMatch(ingredientName)) {
      // Ingredient name cannot contain numbers
      return false;
    }

    // Check if ingredientWeight is a valid numeric value
    try {
      double.parse(ingredientWeight);
    } catch (e) {
      return false;
    }

    // Check API for ingredient validity
    if (await api.ingredientAPICheck(ingredientName)) {
      // All validations passed, the ingredient is considered valid
      return true;
    } else {
      return false;
    }
  }
}
