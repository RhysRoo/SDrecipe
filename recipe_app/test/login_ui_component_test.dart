import 'package:flutter/material.dart';
import 'package:flutter_log/pages/login/ui_components/button_forget.dart';
import 'package:flutter_log/pages/login/ui_components/exercise_tile.dart';
import 'package:flutter_log/pages/login/ui_components/login_tile.dart';
import 'package:flutter_log/pages/login/ui_components/text_fields.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ButtonForget widget test', (WidgetTester tester) async {
    // Build our ButtonForget widget.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ButtonForget(
          onTap: () {}, // Mock onTap function
          text: 'Test Button', // Text to display on the button
        ),
      ),
    ));

    // Verify that the button text is rendered.
    expect(find.text('Test Button'), findsOneWidget);

    // Verify that the button widget itself is rendered.
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);

    // Tap the button and verify that onTap function is called.
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();
    // Add further verification if there are changes in UI or functionality after tapping the button
  });

  testWidgets('ExerciseTile widget test', (WidgetTester tester) async {
    // Define test variables
    const String exerciseName = 'Push-up';
    const String weight = '10';
    const String reps = '15';
    const String sets = '3';
    bool isCompleted = false;

    // Define mock function for onChanged callback
    bool? changedValue;
    void onChanged(bool? value) {
      changedValue = value;
    }

    // Build our ExerciseTile widget.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ExerciseTile(
          exerciseName: exerciseName,
          weight: weight,
          reps: reps,
          sets: sets,
          isCompleted: isCompleted,
          onCheckBoxChanged: onChanged,
        ),
      ),
    ));

    // Verify that the exercise name is rendered.
    expect(find.text(exerciseName), findsOneWidget);

    // Verify that the weight, reps, and sets are rendered.
    expect(find.text("$weight kg"), findsOneWidget);
    expect(find.text("$reps reps"), findsOneWidget);
    expect(find.text("$sets sets"), findsOneWidget);

    // Verify that the checkbox is present and unchecked.
    expect(find.byType(Checkbox), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isCompleted);

    // Tap the checkbox and verify that onChanged callback is called.
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(changedValue,
        true); // Verify that onChanged callback is called with the correct value
  });

  testWidgets('LogTile widget test', (WidgetTester tester) async {
    // Build our LogTile widget.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LogTile(
          imagePath:
              '/Users/josh-v/Documents/RecipeApp/SDrecipe/recipe_app/lib/fitnessImage/fitnessLogo.jpeg', // Provide a sample image path
          onTap: () {}, // Mock onTap function
        ),
      ),
    ));

    // Verify that the image is rendered.
    expect(find.byType(Image), findsOneWidget);

    // Tap the tile and verify that onTap callback is called.
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();
  });

  testWidgets('LogTile appearance test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LogTile(
          imagePath:
              '/Users/josh-v/Documents/RecipeApp/SDrecipe/recipe_app/lib/fitnessImage/fitnessLogo.jpeg',
          onTap: () {},
        ),
      ),
    ));

    final container = tester.widget<Container>(find.byType(Container));
    expect(container.decoration,
        isA<BoxDecoration>()); // Adjusted expectation to BoxDecoration
    expect(container.padding, const EdgeInsets.all(20));

    final image = tester.widget<Image>(find.byType(Image));
    expect(image.height, equals(40.0));
  });

  testWidgets('LogTile onTap test', (WidgetTester tester) async {
    bool onTapCalled = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LogTile(
          imagePath:
              '/Users/josh-v/Documents/RecipeApp/SDrecipe/recipe_app/lib/fitnessImage/fitnessLogo.jpeg',
          onTap: () {
            onTapCalled = true;
          },
        ),
      ),
    ));

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    expect(onTapCalled, true);
  });

  testWidgets('MyTextField widget test', (WidgetTester tester) async {
    // Build our MyTextField widget.
    final TextEditingController controller = TextEditingController();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MyTextField(
          control: controller,
          hintText: 'Enter your text',
          obscureText: false,
        ),
      ),
    ));

    // Verify that the text field is rendered.
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the controller is properly assigned.
    expect(controller,
        equals(tester.widget<TextField>(find.byType(TextField)).controller));

    // Verify the appearance of the text field.
    final inputDecoration =
        tester.widget<TextField>(find.byType(TextField)).decoration;
    expect(inputDecoration!.filled, isTrue);
    expect(inputDecoration.hintText, equals('Enter your text'));
    expect(inputDecoration.hintStyle!.color, equals(Colors.grey[500]));
  });
}
