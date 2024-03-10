import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  List<Map<String, dynamic>> _ingredients = [];
  String _selectedUnit = 'Select Unit';
  List<String> _units = ['Select Unit', 'Cups', 'Grams', 'Pieces'];

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
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        String ingredient = _ingredientController.text;
                        String quantity = _quantityController.text;
                        _ingredients.add({
                          'ingredient': ingredient,
                          'quantity': quantity.isNotEmpty
                              ? '$quantity $_selectedUnit'
                              : null,
                        });
                        _ingredientController.clear();
                        _quantityController.clear();
                        _selectedUnit = 'Select Unit';
                      });
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
                      // TODO: Save the recipe with ingredients to the system
                      _saveRecipe();
                    },
                    child: const Text('Save Recipe'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Clear all ingredients
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

  void _saveRecipe() {
    // TODO: Implement the logic to save the recipe with ingredients to the system
    String recipeName = _recipeNameController.text;
    // Save recipe name and ingredients to the system
    print('Recipe Name: $recipeName');
    print('Ingredients: $_ingredients');
  }
}
