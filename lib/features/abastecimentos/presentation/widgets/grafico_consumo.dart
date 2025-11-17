import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/models/abastecimento_model.dart';

class GraficoConsumo extends StatelessWidget {
  final List<AbastecimentoModel> dados;

  const GraficoConsumo({super.key, required this.dados});

  @override
  Widget build(BuildContext context) {
    if (dados.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("Nenhum dado suficiente para gerar gráfico."),
      );
    }

    final dadosOrdenados = [...dados].reversed.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            "Consumo (km/L)",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          height: 220,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),

              titlesData: FlTitlesData(
                show: true,

                // Remove números do eixo X
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),

                // Opcional: mostra Y com poucos valores
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    interval: 5, // mostra de 5 em 5 km/L
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),

                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),

              minX: 0,
              maxX: (dadosOrdenados.length - 1).toDouble(),
              minY: 0,
              maxY: dadosOrdenados
                      .map((e) => e.consumo)
                      .reduce((a, b) => a > b ? a : b) +
                  2,

              // Linha do gráfico
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (int i = 0; i < dadosOrdenados.length; i++)
                      FlSpot(i.toDouble(), dadosOrdenados[i].consumo),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  dotData: FlDotData(show: true),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
