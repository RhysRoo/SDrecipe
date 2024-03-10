// import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class FAQ_Manager {
//   Future<List<QueryDocumentSnapshot<Object?>>> getQuestionsWithFieldThreeTrue() async {
//   try {
//     // Reference to your collection in Firestore
//     CollectionReference questionsCollection = _firestore.collection('your_collection_name');

//     // Query for documents where 'questions' array has 'field_three' set to true
//     QuerySnapshot<Object?> querySnapshot = await questionsCollection
//         .where('questions.2', isEqualTo: true)
//         .get();

//     // Print the query snapshot for debugging
//     print('Query Snapshot: $querySnapshot');

//     // Return the list of documents
//     return querySnapshot.docs;
//   } catch (e) {
//     print('Error retrieving questions: $e');
//     return [];
//   }
// }

// }

// void main() {
//   FAQ_Manager faq_manager = FAQ_Manager();
//   print(faq_manager.fetchQuestionsWithTrueBoolean());
// }
