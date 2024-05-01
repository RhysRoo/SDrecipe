import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

  List<String> imageUrls = [
    '', '', '', '', ''
  ];

  void updateContent() async {
    List<String> names = await _recipeService.getRecipeNames();
    List<String> urls = await _recipeService.getRecipeUrls();
    List<String> images = await _recipeService.getRecipeImage();

    setState(() {
      sectionTitles = names;
      sectionTexts = urls.map((url) => url ?? 'URL not available').toList();
      imageUrls = images;
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
      child: Row(
        children: [
          imageUrls[index].isNotEmpty ? Image.network(imageUrls[index], width: 100, height: 100, fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return const Icon(Icons.error); // Shows an error icon if the image fails to load
            },
          )
              : Container(),
          Expanded(
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
                InkWell(
                  onTap: () => _launchURL(sectionTexts[index]),
                  child: Text(
                    "Link",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
