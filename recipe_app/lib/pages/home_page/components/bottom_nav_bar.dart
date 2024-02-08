// import 'package:flutter/material.dart';

// abstract class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: Align(
//         //nav bar
//         alignment: Alignment(0.0, 1.0),
//         child: Container(
//           color: Colors.cyan,
//           height: MediaQuery.of(context).size.height * 0.1,
//           width: MediaQuery.of(context).size.width * 1,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.08,
//                   width: MediaQuery.of(context).size.width * 0.3,
//                   color: Colors.black,
//                   child: MaterialButton(
//                     color: Colors.pink,
//                     onPressed: () {},
//                     child: Icon(Icons.access_alarm_outlined, size: 60),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.08,
//                   width: MediaQuery.of(context).size.width * 0.3,
//                   color: Colors.black,
//                   child: MaterialButton(
//                     color: Colors.pink,
//                     onPressed: () {},
//                     child: Icon(Icons.accessibility_new_outlined, size: 60),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.08,
//                   width: MediaQuery.of(context).size.width * 0.3,
//                   color: Colors.black,
//                   child: MaterialButton(
//                     color: Colors.pink,
//                     onPressed: () {},
//                     child: Icon(Icons.add_to_photos, size: 60),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
