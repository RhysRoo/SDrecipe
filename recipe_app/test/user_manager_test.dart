import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() {
  MockFirestore fire_instance;
  MockDocumentSnapshot mockDocumentSnapshot;
  MockCollectionReference mockCollectionReference;
  MockDocumentReference mockDocumentReference;

  setUp(() {
    fire_instance = MockFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
  });

  // test('should return data when called', () async {
  //   when(fire_instance.collection(any)).thenReturn(mockCollectionReference as CollectionReference<Map<String, dynamic>>);
  // });
}
