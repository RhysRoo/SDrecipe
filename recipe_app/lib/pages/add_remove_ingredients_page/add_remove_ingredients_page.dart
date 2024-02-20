import 'package:flutter/material.dart';

class AddRemoveIngredients extends StatefulWidget {
  const AddRemoveIngredients({Key? key}) : super(key: key);

  @override
  _AddRemoveIngredientsState createState() => _AddRemoveIngredientsState();
}

class _AddRemoveIngredientsState extends State<AddRemoveIngredients> {
  List<String> ingredients = [];

  final TextEditingController ingredientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Add and Remove Ingredients Page'),
      ),
      backgroundColor: Colors.green[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIngredientForm(),
                const SizedBox(height: 20.0),
                _buildIngredientsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientForm() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: ingredientController,
            decoration: const InputDecoration(
              hintText: 'Enter ingredient...',
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        ElevatedButton(
          onPressed: () {
            _addIngredient();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  Widget _buildIngredientsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredients:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        ListView.builder(
          shrinkWrap: true,
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3.0,
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                title: Text(ingredients[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _removeIngredient(index);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _addIngredient() {
    final newIngredient = ingredientController.text.trim();
    if (newIngredient.isNotEmpty) {
      setState(() {
        ingredients.add(newIngredient);
        ingredientController.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }
}
 