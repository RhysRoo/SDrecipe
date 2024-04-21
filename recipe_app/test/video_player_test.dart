// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_log/pages/home_page/components/video_player.dart';

class MockVideoPlayerController extends Mock implements VideoPlayerController {}

void main() {
  testWidgets('VideoPlayerWidget should be created and rendered',
      (WidgetTester tester) async {
    final mockController = MockVideoPlayerController();

    when(mockController.value).thenReturn(
      VideoPlayerValue(
        duration: Duration.zero,
      ),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: VideoPlayerWidget()));

    // Verify that the VideoPlayerWidget is rendered.
    expect(find.byType(VideoPlayerWidget), findsOneWidget);

    // Verify that the VideoPlayerController is initialized.
    verify(mockController.initialize()).called(1);

    // Dispose the widget and verify that the VideoPlayerController is disposed.
    await tester.pumpWidget(Container());
    verify(mockController.dispose()).called(1);
  });
}
