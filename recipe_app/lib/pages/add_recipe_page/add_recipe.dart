// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_log/pages/add_recipe_page/add_recipe_manager.dart';
import 'package:flutter_log/pages/add_remove_ingredients_page/ingredientManager.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  AddRemoveRecipeManager addRemoveRecipeManager = AddRemoveRecipeManager();
  IngredientManager ingredientManager = IngredientManager();
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final List<Map<String, dynamic>> _ingredients = [];
  String _selectedUnit = 'Select Unit';
  final List<String> _units = ['Select Unit', 'Cups', 'Grams', 'Pieces'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Add/Remove Recipes'),
      ),
      backgroundColor: Colors.green[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Recipe Name:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _recipeNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter recipe name',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Ingredients:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ingredientController,
                      decoration: const InputDecoration(
                        hintText: 'Enter ingredient',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Quantity',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _selectedUnit,
                    items: _units.map((unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnit = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 16.0),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _addIngredient();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Recipe Ingredients:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: _ingredients.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        child: const Text('No ingredients added yet.'),
                      )
                    : _buildIngredientsList(),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _saveRecipe();
                    },
                    child: const Text('Save Recipe'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _ingredients.clear();
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: const Text('Clear Ingredients'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = _ingredients[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              ingredient['ingredient'],
              style: const TextStyle(fontSize: 16),
            ),
            subtitle: ingredient['quantity'] != null
                ? Text('Quantity: ${ingredient['quantity']}')
                : null,
            trailing: IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  _ingredients.removeAt(index);
                });
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _addIngredient() async {
    String ingredient = _ingredientController.text;
    String quantity = _quantityController.text;

    // Validation: Check if ingredient and quantity are not empty
    if (await _validateIngredient(ingredient, quantity)) {
      setState(() {
        _ingredients.add({
          'ingredient': ingredient,
          'quantity': quantity.isNotEmpty ? '$quantity $_selectedUnit' : null,
        });
        _ingredientController.clear();
        _quantityController.clear();
        _selectedUnit = 'Select Unit';
      });
    }
  }

  Future<bool> _validateIngredient(String ingredient, String quantity) async {
    if (ingredient.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an ingredient.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Show loading indicator while checking ingredient validity
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Checking ingredient validity...'),
        backgroundColor: Colors.blue,
      ),
    );

    // Simulate an API call to check ingredient validity
    await Future.delayed(const Duration(seconds: 2));

    // Replace the condition with your actual API check for ingredient validity
    if (await ingredientManager.checkIngredientIsValid(ingredient, quantity) ==
        false) {
      // Hide loading indicator and show an error Snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Ingredient not found. Please enter a valid ingredient.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Check if quantity is not zero
    if (quantity.isNotEmpty) {
      double parsedQuantity = double.tryParse(quantity) ?? 0;
      if (parsedQuantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid quantity greater than 0.'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }

    // If everything is valid, return true
    return true;
  }

  Future<void> _saveRecipe() async {
    String recipeName = _recipeNameController.text;

    // Validation: Check if recipe name and ingredients are not empty
    if (recipeName.isNotEmpty && _ingredients.isNotEmpty) {
      // Save recipe name and ingredients to the system
      await addRemoveRecipeManager.saveRecipe(_ingredients, recipeName);
      setState(() {
        _ingredients.clear();
      });
    } else {
      // Display specific error messages for empty fields
      if (recipeName.isEmpty && _ingredients.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a recipe name and add ingredients.'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (recipeName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a recipe name.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add ingredients.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
