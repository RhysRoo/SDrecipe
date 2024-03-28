// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';


//questions and awnser set up
class QAItem extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color backgroundColor;
  final Color titleColor;
  final Color childrenColor;


  const QAItem({
    Key? key,
    required this.title,
    required this.children,
    this.backgroundColor = Colors.green,
    this.titleColor = Colors.black,
    this.childrenColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
            color: titleColor, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      children: children
          .map((child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: DefaultTextStyle(
                    style: TextStyle(color: childrenColor, fontSize: 16.0),
                    child: child,
                  ),
                ),
              ))
          .toList(),
      backgroundColor: backgroundColor,
    );
  }
}

class FAQ_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),//title
        backgroundColor: Colors.green,//background
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(//search container
                  color: Colors.green[700],
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Search',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: SizedBox(
                              height: 50.0,
                              child: TextField(//text box to search (not functional)
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: TextStyle(color: Colors.black),
                                minLines: 1,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              // button to search (not functional)
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                              minimumSize: const Size(0, 50),
                            ),
                            child: const Text(
                              'search', // search button
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //coad for each q and a
          const QAItem(
            title: 'Q: What is the main goal of the Recipe Generator app?',
            children: [
              Text(
                  'A: The core concept of this system is to mitigate environmental impact by reducing food waste, aligning with sustainable practices.'),
            ],
          ),
          const QAItem(
            title: 'Q: Who are the primary users of the Recipe Generator app?',
            children: [
              Text(
                  'A: The primary users are registered WasteAway users who seek to reduce food waste and generate personalized recipes.'),
            ],
          ),
          const QAItem(
            title: 'Q: How does the Recipe Generation feature work?',
            children: [
              Text(
                  'A: Users select ingredients through the form, triggering the recipe generation process. The system generates recipes based on selected ingredients and user food restrictions.'),
            ],
          ),
          const QAItem(
            title:
                'Q: Can I customize the generated recipes based on dietary restrictions?',
            children: [
              Text(
                  'A: Yes, users can set dietary preferences and restrictions, ensuring that the generated recipes align with their specific needs.'),
            ],
          ),
          const QAItem(
            title:
                'Q: What happens if I don\'t provide enough ingredients for the generation process?',
            children: [
              Text(
                  'A: If not enough ingredients or ingredient types are provided, an error message will be displayed, prompting users to select more ingredients and re-initiate the process.'),
            ],
          ),
          const QAItem(
            title: 'Q: How are ingredients saved in the app?',
            children: [
              Text(
                  'A: Users can save ingredients through the Save Ingredients feature. The ingredient manager validates the data, and the ingredients are stored in the backend attached to the user\'s profile.'),
            ],
          ),
          const QAItem(
            title: 'Q: Can I edit my user profile details?',
            children: [
              Text(
                  'A: Yes, users can edit their user profile details, including name, email, password, food restrictions, and bio. The updated information is then reflected in the backend.'),
            ],
          ),
          const QAItem(
            title:
                'Q: What happens if I enter incorrect data during profile editing?',
            children: [
              Text(
                  'A: If there\'s invalid data, the app displays an error message (e.g., "Invalid Name Entry" or "Invalid Password Entry"). Users correct the form and resubmit.'),
            ],
          ),
          const QAItem(
            title: 'Q: How does the app handle expired ingredients?',
            children: [
              Text(
                  'A: The app notifies users of expired ingredients during the recipe generation process. Users can choose to continue without expired items or halt the process to add more ingredients.'),
            ],
          ),
          const QAItem(
            title: 'Q: Can I add my own recipes to the app?',
            children: [
              Text(
                  'A: Yes, users can add their own recipes through the Add Own Recipes feature. The system validates the submitted details, and upon success, the custom recipe is added to the app\'s database.'),
            ],
          ),
          const QAItem(
            title:
                'Q: What happens if I make errors while adding my own recipe?',
            children: [
              Text(
                  'A: If there are errors (e.g., missing fields), the app displays an error message, allowing users to review and correct their form before submission.'),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(// button for add question (not functional)
            onPressed: () {
              // Add code for handling the button press
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.green[700],
            ),
            child: const Text('Add Question'),
          ),
        ],
      ),
    );
  }
}
