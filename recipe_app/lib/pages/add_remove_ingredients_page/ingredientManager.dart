import 'add_remove_ingredients_page.dart';

void _getUserIngredients() {
  // Obtains List from Cloud
}

void _flushUserIngredients() {
  // Concatenate New List with Cloud
}

void pushUserIngredients() {
  // Send List to Cloud
}

void adequateIngredients() {
  // Check that the obtained grams is adequate for a recipe
}

bool checkIngredientIsValid(String ingredientName, String ingredientWeight) {
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

  // All validations passed, the ingredient is considered valid
  return true;
}
