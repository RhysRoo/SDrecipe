import 'package:flutter/material.dart';


class QAItem extends StatelessWidget {
  const QAItem({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final Widget title;
  final List<Widget> children;

  

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: title,
      children: children.map((child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 16.0), // Set the text size
            child: child,
          ),
        ),
      )).toList(),
    );
  }
}

class FAQ_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequently Asked Questions'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Row(
            children: [
              
              
              
              
              
              
Expanded(
  child: Container(
    color: Colors.green[700],
    height: MediaQuery.of(context).size.height * 0.20,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
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
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 50.0, // Adjust the height as needed
                child: TextField(
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
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                minimumSize: Size(0, 50), // Set the minimum size to match the height of the text field
              ),
              child: Text(
                'Search',
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

          QAItem(
            title: Text('Q: What is the main goal of the Recipe Generator app?'),
            children: [
              Text('A: The core concept of this system is to mitigate environmental impact by reducing food waste, aligning with sustainable practices.'),
            ],
          ),
          QAItem(
            title: Text('Q: Who are the primary users of the Recipe Generator app?'),
            children: [
              Text('A: The primary users are registered WasteAway users who seek to reduce food waste and generate personalized recipes.'),
            ],
          ),
          QAItem(
            title: Text('Q: How does the Recipe Generation feature work?'),
            children: [
              Text('A: Users select ingredients through the form, triggering the recipe generation process. The system generates recipes based on selected ingredients and user food restrictions.'),
            ],
          ),
          QAItem(
            title: Text('Q: Can I customize the generated recipes based on dietary restrictions?'),
            children: [
              Text('A: Yes, users can set dietary preferences and restrictions, ensuring that the generated recipes align with their specific needs.'),
            ],
          ),
          QAItem(
            title: Text('Q: What happens if I don\'t provide enough ingredients for the generation process?'),
            children: [
              Text('A: If not enough ingredients or ingredient types are provided, an error message will be displayed, prompting users to select more ingredients and re-initiate the process.'),
            ],
          ),
          QAItem(
            title: Text('Q: How are ingredients saved in the app?'),
            children: [
              Text('A: Users can save ingredients through the Save Ingredients feature. The ingredient manager validates the data, and the ingredients are stored in the backend attached to the user\'s profile.'),
            ],
          ),
          QAItem(
            title: Text('Q: Can I edit my user profile details?'),
            children: [
              Text('A: Yes, users can edit their user profile details, including name, email, password, food restrictions, and bio. The updated information is then reflected in the backend.'),
            ],
          ),
          QAItem(
            title: Text('Q: What happens if I enter incorrect data during profile editing?'),
            children: [
              Text('A: If there\'s invalid data, the app displays an error message (e.g., "Invalid Name Entry" or "Invalid Password Entry"). Users correct the form and resubmit.'),
            ],
          ),
          QAItem(
            title: Text('Q: How does the app handle expired ingredients?'),
            children: [
              Text('A: The app notifies users of expired ingredients during the recipe generation process. Users can choose to continue without expired items or halt the process to add more ingredients.'),
            ],
          ),
          QAItem(
            title: Text('Q: Can I add my own recipes to the app?'),
            children: [
              Text('A: Yes, users can add their own recipes through the Add Own Recipes feature. The system validates the submitted details, and upon success, the custom recipe is added to the app\'s database.'),
            ],
          ),
          QAItem(
            title: Text('Q: What happens if I make errors while adding my own recipe?'),
            children: [
              Text('A: If there are errors (e.g., missing fields), the app displays an error message, allowing users to review and correct their form before submission.'),
             ],
          ),
 
          SizedBox(height: 16), 
TextButton(
  onPressed: () {
  },
  style: TextButton.styleFrom(
    backgroundColor: Colors.green, 
    primary: Colors.white,
  ),
  child: Text('Add Question'),
),
        ],
      ),
    );
  }
}