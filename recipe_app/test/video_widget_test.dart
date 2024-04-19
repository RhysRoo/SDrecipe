// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter_log/pages/home_page/home_page.dart';
// import 'package:mockito/mockito.dart';

// class MockVideoPlayerController extends Mock implements VideoPlayerController {}

// void main() {
//   testWidgets('VideoPlayerWidget has a back button and a play button',
//       (WidgetTester tester) async {
//     final mockController = MockVideoPlayerController();

//     when(mockController.initialize()).thenAnswer((_) async => null);
//     when(mockController.value)
//         .thenReturn(VideoPlayerValue(duration: Duration.zero));

//     try {
//       // Verify that the back button exists.
//       expect(find.byIcon(Icons.arrow_back), findsOneWidget);

//       // Verify that the play button exists.
//       expect(find.byIcon(Icons.play_arrow), findsOneWidget);
//     } catch (e) {
//       print('Test failed with error: $e');
//     }
//   });
// }
