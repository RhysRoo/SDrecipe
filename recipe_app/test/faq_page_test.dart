import 'package:flutter/material.dart';
import 'package:flutter_log/pages/faqs_page/FAQ_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QAItem Widget Tests', () {
    testWidgets('QAItem widget should display title and children',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QAItem(
              title: 'Test Question',
              children: [
                Text('Test Answer'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Test Question'), findsOneWidget);
    });
  });

  group('FAQ_page Widget Tests', () {
    testWidgets('FAQ_page widget should display app bar and list of QAItems',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FAQ_page(),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(QAItem), findsWidgets);
    });

    // You can write more tests for functionality like testing the search feature and the "Add Question" button
  });
}
