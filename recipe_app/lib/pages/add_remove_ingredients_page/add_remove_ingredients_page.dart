import 'package:flutter/material.dart';
import 'ingredientManager.dart';

class AddRemoveIngredients extends StatefulWidget {
  const AddRemoveIngredients({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddRemoveIngredientsState createState() => _AddRemoveIngredientsState();
}

class _AddRemoveIngredientsState extends State<AddRemoveIngredients> {
  List<List<String>> ingredients = [];

  final TextEditingController ingredientController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  bool shouldFlush = false;

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
                    _flushIngredients();
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
        if (shouldFlush) // Conditionally render based on the flush action
          const Text(
            'Ingredients flushed!',
            style: TextStyle(color: Colors.red),
          )
        else
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
      if (!checkIngredientIsValid(newIngredient, newIngredientWeight)) {
        // Show a SnackBar with the error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid ingredient! Please check your input.'),
            duration: Duration(seconds: 2), // Adjust as needed
          ),
        );
        return; // Exit the method if validation fails
      }

      // Check if the ingredient already exists
      int existingIndex = ingredients
          .indexWhere((ingredient) => ingredient[0] == newIngredient);

      setState(() {
        if (existingIndex != -1) {
          // Ingredient already exists, add the weights together
          int existingWeight = int.tryParse(ingredients[existingIndex][1]) ?? 0;
          int newWeight = int.tryParse(newIngredientWeight) ?? 0;
          ingredients[existingIndex][1] =
              (existingWeight + newWeight).toString();
        } else {
          // Ingredient doesn't exist, add a new entry
          ingredients.add([newIngredient, newIngredientWeight]);
        }
        ingredientController.clear();
        weightController.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  void _flushIngredients() {
    setState(() {
      ingredients.clear(); // Clear the ingredients list
      shouldFlush = true; // Set the flag to trigger the flush message
    });

    // Reset the flag after a delay (to display the flush message for a moment)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        shouldFlush = false;
      });
    });
  }
}
