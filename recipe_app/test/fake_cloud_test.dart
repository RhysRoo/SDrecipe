import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

class TestRepository {
  final FirebaseFirestore firestore;
  TestRepository({required this.firestore});

  late final countDoc = firestore.doc('test/doc_12345');

  Future<int?> fetch() async {
    final snapshot = await countDoc.get();
    return snapshot.data()?['count'];
  }
}

void main() {
  group('userManager tests', () {
    // 1
    final firestore = FakeFirebaseFirestore();
    late TestRepository testRepository;
    setUp(
      () {
        // 2
        testRepository = TestRepository(firestore: firestore);
        // 3
        setDummyFirestore(firestore);
      },
    );

    test('Test fetch data', () async {
      // 4
      final result = await testRepository.fetch();
      expect(result, 2);
    });
  });
}

setDummyFirestore(FirebaseFirestore firestore) {
  firestore.collection('test').doc('doc_12345').set({
    'count': 2,
  });
}