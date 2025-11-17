import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/abastecimento_model.dart';

class AbastecimentoRepository {
  final _fire = FirebaseFirestore.instance;

  CollectionReference _collection() {
    final user = FirebaseAuth.instance.currentUser;
    return _fire
        .collection('users')
        .doc(user!.uid)
        .collection('abastecimentos');
  }

  Future<void> add(AbastecimentoModel a) async {
    await _collection().add(a.toMap());
  }

  Future<void> delete(String id) async {
    await _collection().doc(id).delete();
  }

  Stream<List<AbastecimentoModel>> streamAbastecimentos() {
    return _collection().orderBy('data', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return AbastecimentoModel.fromMap(
              doc.id, doc.data() as Map<String, dynamic>);
        }).toList();
      },
    );
  }
}
