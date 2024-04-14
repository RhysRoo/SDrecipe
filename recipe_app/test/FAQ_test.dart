import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_log/pages/faqs_page/FAQ_page.dart';

void main() {
  testWidgets('Test FAQ_page Widget ExpansionTiles', (WidgetTester tester) async {
    // Build FAQ_page widget
    await tester.pumpWidget(MaterialApp(home: FAQ_page()));

    // Verify AppBar
    expect(find.text('Frequently Asked Questions'), findsOneWidget); // Check if the app bar title is displayed

    // Find ExpansionTile widgets
    final expansionTiles = find.byType(ExpansionTile);

    // Verify ExpansionTile widgets are displayed
    expect(expansionTiles, findsWidgets);

    // Verify QAItem widgets
    final qaItems = [
      {
        'title': 'Q: What is the main goal of the Recipe Generator app?',
        'answer': 'A: The core concept of this system is to mitigate environmental impact by reducing food waste, aligning with sustainable practices.',
      },
      {
        'title': 'Q: Who are the primary users of the Recipe Generator app?',
        'answer': 'A: The primary users are registered WasteAway users who seek to reduce food waste and generate personalized recipes.',
      },
      {
        'title': 'Q: How does the Recipe Generation feature work?',
        'answer': 'A: Users select ingredients through the form, triggering the recipe generation process. The system generates recipes based on selected ingredients and user food restrictions.',
      },
      {
        'title': 'Q: Can I customize the generated recipes based on dietary restrictions?',
        'answer': 'A: Yes, users can set dietary preferences and restrictions, ensuring that the generated recipes align with their specific needs.',
      },
      {
        'title': 'Q: What happens if I don\'t provide enough ingredients for the generation process?',
        'answer': 'A: If not enough ingredients or ingredient types are provided, an error message will be displayed, prompting users to select more ingredients and re-initiate the process.',
      },
      {
        'title': 'Q: How are ingredients saved in the app?',
        'answer': 'A: Users can save ingredients through the Save Ingredients feature. The ingredient manager validates the data, and the ingredients are stored in the backend attached to the user\'s profile.',
      },
      {
        'title': 'Q: Can I edit my user profile details?',
        'answer': 'A: Yes, users can edit their user profile details, including name, email, password, food restrictions, and bio. The updated information is then reflected in the backend.',
      },
      {
        'title': 'Q: What happens if I enter incorrect data during profile editing?',
        'answer': 'A: If there\'s invalid data, the app displays an error message (e.g., "Invalid Name Entry" or "Invalid Password Entry"). Users correct the form and resubmit.',
      },
      {
        'title': 'Q: How does the app handle expired ingredients?',
        'answer': 'A: The app notifies users of expired ingredients during the recipe generation process. Users can choose to continue without expired items or halt the process to add more ingredients.',
      },
      {
        'title': 'Q: Can I add my own recipes to the app?',
        'answer': 'A: Yes, users can add their own recipes through the Add Own Recipes feature. The system validates the submitted details, and upon success, the custom recipe is added to the app\'s database.',
      },
      {
        'title': 'Q: What happens if I make errors while adding my own recipe?',
        'answer': 'A: If there are errors (e.g., missing fields), the app displays an error message, allowing users to review and correct their form before submission.',
      },
    ];

    for (var qaItemData in qaItems) {
      final title = qaItemData['title'] as String;
      final answer = qaItemData['answer'] as String;

      // Find the ExpansionTile widget
      final expansionTileFinder = find.text(title);
final expansionTile = tester.widgetList<ExpansionTile>(expansionTileFinder).single;
      expect(expansionTile, isA<ExpansionTile>());

      // Assuming each ExpansionTile has only one child Container widget
      final container = find.descendant(of: expansionTileFinder, matching: find.byType(Container));
      expect(container, findsOneWidget);

      // Test properties of the Container (which contains QAItem)
      final containerWidget = tester.widget<Container>(container);
      expect(containerWidget.color, equals(Colors.green));

      // Assuming each Container has only one child Text widget
      final textWidget = find.descendant(of: container, matching: find.byType(Text));
      expect(textWidget, findsOneWidget);
      expect((tester.widget<Text>(textWidget)).data, equals(answer));
    }
  });
}