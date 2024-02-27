// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/open_food_api.dart';
import 'package:flutter_log/pages/profile_page/userManager.dart';

// DO NOT TOUCH THIS CODE, THANK YOU VERY MUCH

class IngredientManager {
  IngredientAPI api = IngredientAPI();
  UserManager user = UserManager();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Returns the list of ingredients from the cloud that the user has entered
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

  // Stores the ingredients into the cloud
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

  // Returns if the quantity of an ingredient is valid to produce a recipe
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

  // Returns false if the ingredient is in correct format before API search
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

  DateTime convertStringtoDatetime(userDatetime) {
    // BUG DETECTED
    if (userDatetime == null || userDatetime.isEmpty) {
      throw ArgumentError("Input string is null or empty");
    }

    try {
      DateTime ingredientDateTime = DateTime.parse(userDatetime);
      return ingredientDateTime;
    } catch (e) {
      // Handle parsing errors
      throw ArgumentError("Invalid date format");
    }
  }

  bool checkDateTimeAgainstTodaysDate(String? userDatetime) {
    // BUG DETECTED
    if (userDatetime == null || userDatetime.isEmpty) {
      return false; // Null or empty strings are not in the correct format
    }

    // Define a regex pattern for the "YYYY-MM-DD" format
    RegExp datePattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

    // Check if the input string matches the pattern
    return datePattern.hasMatch(userDatetime);
  }

  bool checkUserDateTime(String? userDatetime) {
    if (userDatetime == null || userDatetime.isEmpty) {
      return false; // Null or empty strings are not in the correct format
    }

    // Define a regex pattern for the "YYYY-MM-DD" format
    RegExp datePattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

    // Check if the input string matches the pattern
    if (!datePattern.hasMatch(userDatetime)) {
      return false; // Return false if the format doesn't match
    }

    // Parse the input string into a DateTime object
    DateTime parsedDateTime;
    try {
      parsedDateTime = DateTime.parse(userDatetime);
    } catch (e) {
      return false; // Return false if parsing fails
    }

    // Compare the parsed date with today's date
    DateTime today = DateTime.now();
    return parsedDateTime.isAfter(today);
  }
}
