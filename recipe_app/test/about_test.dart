import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_log/pages/about_us_page/about_page.dart';

void main() {
  testWidgets('AppBar Widget Test in AboutPage', (WidgetTester tester) async {
    // Build a MaterialApp with the AboutPage as a route
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutUsPage(),
      ),
    );

    // Find the AppBar widget by its type
    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsOneWidget);

    // Verify the title text of the AppBar
    final Text titleTextWidget = tester.widget<Text>(
      find.descendant(
        of: appBarFinder,
        matching: find.byType(Text),
      ),
    );
    expect(titleTextWidget.data, 'About Us');
    expect(titleTextWidget.style!.fontSize, 45);

    // Verify the background color of the AppBar
    final AppBar appBarWidget = tester.widget(appBarFinder);
    expect(appBarWidget.backgroundColor, Colors.green);

    // Verify the toolbar height of the AppBar
    expect(appBarWidget.toolbarHeight, tester.getSize(appBarFinder).height);

    // Verify that the page doesn't overflow
    await tester.pumpAndSettle(); // Wait for the layout to settle
    expect(tester.takeException(), isNull);
  });
}