import 'package:flutter/material.dart';
import 'api_search.dart';

class GenerationPage extends StatefulWidget {
  const GenerationPage({super.key});

  @override
  State<GenerationPage> createState() => _GenerationPageState();
}

class _GenerationPageState extends State<GenerationPage> {
  final RecipeService _recipeService = RecipeService();

  List<String> sectionTitles = [
    'Recipe 1',
    'Recipe 2',
    'Recipe 3',
    'Recipe 4',
    'Recipe 5',
  ];

  List<String> sectionTexts = [
    'Click \'generate recipes\' to generate!',
    'Click \'generate recipes\' to generate!',
    'Click \'generate recipes\' to generate!',
    'Click \'generate recipes\' to generate!',
    'Click \'generate recipes\' to generate!',
  ];

  void updateContent() async {
    List<String> names = await _recipeService.getRecipeNames();
    List<String> urls = await _recipeService.getRecipeUrls();

    setState(() {
      sectionTitles = names;
      sectionTexts = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Generation Page'),
      ),
      backgroundColor: Colors.green[200],
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.025,
                right: MediaQuery.of(context).size.width * 0.025,
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.teal[600],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) => _buildSection(context, index)),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () => setState(() {
                updateContent();
              }),
              child: const Text(
                'Change Content',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            sectionTitles[index],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            sectionTexts[index],
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
