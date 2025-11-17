import 'package:flutter/material.dart';
import '../../data/repositories/abastecimento_repository.dart';
import '../../data/models/abastecimento_model.dart';

class AbastecimentoController extends ChangeNotifier {
  final _repo = AbastecimentoRepository();

  bool loading = false;
  String? error;

  String? _filtroVeiculoId;

  void setFiltroVeiculo(String? id) {
    _filtroVeiculoId = id;
    notifyListeners();
  }

  String? get filtroVeiculoId => _filtroVeiculoId;

  Future<bool> addAbastecimento({
    required DateTime data,
    required double litros,
    required double valor,
    required double km,
    required String tipoCombustivel,
    required String veiculoId,
    String? observacao,
  }) async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      final ultimo = await _repo.getUltimoAbastecimento(veiculoId);

      double consumo;

      if (ultimo == null) {
        consumo = 0;
      } else {
        final distancia = km - ultimo.quilometragem;

        if (distancia <= 0) {
          consumo = 0; 
        } else {
          consumo = distancia / litros;
        }
      }

      final ab = AbastecimentoModel(
        id: '',
        data: data,
        quantidadeLitros: litros,
        valorPago: valor,
        quilometragem: km,
        tipoCombustivel: tipoCombustivel,
        veiculoId: veiculoId,
        consumo: consumo,
        observacao: observacao,
      );

      await _repo.add(ab);
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> delete(String id) => _repo.delete(id);

  Stream<List<AbastecimentoModel>> streamAbastecimentos() {
    return _repo.streamAbastecimentos().map((lista) {
      if (_filtroVeiculoId == null) return lista;

      return lista.where((a) => a.veiculoId == _filtroVeiculoId).toList();
    });
  }
}
