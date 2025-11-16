import 'package:flutter/material.dart';
import '../../data/models/veiculo_model.dart';
import '../../data/repositories/veiculo_repository.dart';

class VeiculoController extends ChangeNotifier {
  final _repo = VeiculoRepository();

  bool loading = false;
  String? error;

  Future<bool> addVeiculo({
    required String modelo,
    required String marca,
    required String placa,
    required int ano,
    required String tipoCombustivel,
  }) async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      final veiculo = VeiculoModel(
        id: '',
        modelo: modelo,
        marca: marca,
        placa: placa,
        ano: ano,
        tipoCombustivel: tipoCombustivel,
      );

      await _repo.add(veiculo);

      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
  }

  Stream<List<VeiculoModel>> streamVeiculos() {
    return _repo.streamVeiculos();
  }
}
