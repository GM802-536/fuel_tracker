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

    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (dados.length - 1).toDouble(),
          minY: 0,
          maxY: dados.map((e) => e.consumo).reduce((a, b) => a > b ? a : b) + 2,

          titlesData: const FlTitlesData(show: true),

          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: Colors.blue,
              barWidth: 4,
              spots: [
                for (int i = 0; i < dados.length; i++)
                  FlSpot(i.toDouble(), dados[i].consumo),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
