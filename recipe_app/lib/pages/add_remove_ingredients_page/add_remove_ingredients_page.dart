import 'package:flutter/material.dart';

class AddRemoveIngredients extends StatefulWidget {
  const AddRemoveIngredients({Key? key}) : super(key: key);

  @override
  _AddRemoveIngredientsState createState() => _AddRemoveIngredientsState();
}

class _AddRemoveIngredientsState extends State<AddRemoveIngredients> {
  List<List<String>> ingredients = [];

  final TextEditingController ingredientController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Add and Remove Ingredients Page'),
      ),
      backgroundColor: Colors.green[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    // Flush Button
                  },
                  child: const Text('Flush'),
                ),
              ),
              Card(
                elevation: 5.0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      _buildIngredientForm(),
                      const SizedBox(height: 20.0),
                      _buildIngredientsList(),
                    ],
                  ),
                ),
              ),
            ],
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
              hintText: 'Enter ingredient name',
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: TextField(
            controller: weightController,
            decoration: const InputDecoration(
              hintText: 'Enter grams',
            ),
          ),
        ),
        const SizedBox(width: 20.0),
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
        const SizedBox(height: 10.0),
        ListView.builder(
          shrinkWrap: true,
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3.0,
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                title: Text(
                    '${ingredients[index][0]} : ${ingredients[index][1]} g'),
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
    final newIngredient = ingredientController.text.trim(); // String
    final newIngredientWeight =
        weightController.text.trim(); // String converted from integer
    if (newIngredient.isNotEmpty && newIngredientWeight.isNotEmpty) {
      setState(() {
        ingredients.add([newIngredient, newIngredient]);
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
