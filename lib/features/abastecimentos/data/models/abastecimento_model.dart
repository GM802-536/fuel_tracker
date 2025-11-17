class AbastecimentoModel {
  final String id;
  final DateTime data;
  final double quantidadeLitros;
  final double valorPago;
  final double quilometragem;
  final String tipoCombustivel;
  final String veiculoId;
  final double consumo;
  final String? observacao;

  AbastecimentoModel({
    required this.id,
    required this.data,
    required this.quantidadeLitros,
    required this.valorPago,
    required this.quilometragem,
    required this.tipoCombustivel,
    required this.veiculoId,
    required this.consumo,
    this.observacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toIso8601String(),
      'quantidadeLitros': quantidadeLitros,
      'valorPago': valorPago,
      'quilometragem': quilometragem,
      'tipoCombustivel': tipoCombustivel,
      'veiculoId': veiculoId,
      'consumo': consumo,
      'observacao': observacao,
    };
  }

  factory AbastecimentoModel.fromMap(String id, Map<String, dynamic> map) {
    return AbastecimentoModel(
      id: id,
      data: DateTime.parse(map['data']),
      quantidadeLitros: (map['quantidadeLitros'] as num).toDouble(),
      valorPago: (map['valorPago'] as num).toDouble(),
      quilometragem: (map['quilometragem'] as num).toDouble(),
      tipoCombustivel: map['tipoCombustivel'],
      veiculoId: map['veiculoId'],
      consumo: (map['consumo'] as num).toDouble(),
      observacao: map['observacao'],
    );
  }
}
