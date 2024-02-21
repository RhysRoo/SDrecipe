import 'package:flutter/material.dart';
import 'ingredientManager.dart';

class AddRemoveIngredients extends StatefulWidget {
  const AddRemoveIngredients({Key? key}) : super(key: key);

  @override
  _AddRemoveIngredientsState createState() => _AddRemoveIngredientsState();
}

class _AddRemoveIngredientsState extends State<AddRemoveIngredients> {
  List<List<String>> ingredients = [];

  final TextEditingController ingredientController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  bool shouldFlush = false;
  IngredientManager manager = IngredientManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addIngredient();
                    },
                    child: const Text('Add'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        _flushIngredients();
                      },
                      child: const Text('Flush'),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    _flushIngredients();
                  },
                  child: const Text('Save'),
                ),
              ),
              Card(
                elevation: 5.0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.78,
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
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
              hintText: 'Enter ingredient',
            ),
          ),
        ),
        const SizedBox(width: 30.0),
        Expanded(
          child: TextField(
            controller: weightController,
            decoration: const InputDecoration(
              hintText: 'Enter grams',
            ),
          ),
        ),
        const SizedBox(width: 25.0),
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

  Future<void> _addIngredient() async {
    final newIngredient = ingredientController.text.trim();
    final newIngredientWeight = weightController.text.trim();

    // Display a loading indicator while checking for ingredient validity
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Checking Ingredient Validity'),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16.0),
              Text('Checking...'),
            ],
          ),
        );
      },
    );

    try {
      if (newIngredient.isNotEmpty && newIngredientWeight.isNotEmpty) {
        bool isValid = await manager.checkIngredientIsValid(
            newIngredient, newIngredientWeight);

        if (isValid) {
          int existingIndex = ingredients
              .indexWhere((ingredient) => ingredient[0] == newIngredient);

          setState(() {
            if (existingIndex != -1) {
              int existingWeight =
                  int.tryParse(ingredients[existingIndex][1]) ?? 0;
              int newWeight = int.tryParse(newIngredientWeight) ?? 0;
              ingredients[existingIndex][1] =
                  (existingWeight + newWeight).toString();
            } else {
              ingredients.add([newIngredient, newIngredientWeight]);
            }
            ingredientController.clear();
            weightController.clear();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid ingredient! Please check your input.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } finally {
      // Close the loading indicator dialog
      Navigator.pop(context);
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  void _flushIngredients() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Ingredients'),
          content: const Text('Are you sure you want to save the ingredients?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _performFlush();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _performFlush() async {
    // Call the method directly from the imported file
    await manager.flushUserIngredients(ingredients);

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
