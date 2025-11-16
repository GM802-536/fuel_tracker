import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../models/veiculo_model.dart';

class VeiculoRepository {
  final _fire = FirebaseFirestore.instance;
  final _auth = AuthRepository();

  CollectionReference _collection() {
    final user = _auth.currentUser;
    return _fire.collection('users').doc(user!.uid).collection('veiculos');
  }

  Future<void> add(VeiculoModel v) async {
    await _collection().add(v.toMap());
  }

  Future<void> delete(String id) async {
    await _collection().doc(id).delete();
  }

  Stream<List<VeiculoModel>> streamVeiculos() {
    return _collection().snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return VeiculoModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
