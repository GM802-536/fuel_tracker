import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../veiculos/presentation/controllers/veiculo_controller.dart';
import '../controllers/abastecimento_controller.dart';

class FiltroVeiculoDropdown extends StatelessWidget {
  const FiltroVeiculoDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final abastecimento = context.watch<AbastecimentoController>();
    final veiculos = context.watch<VeiculoController>();

    return StreamBuilder(
      stream: veiculos.streamVeiculos(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final lista = snapshot.data!;

        String label = abastecimento.filtroVeiculoId == null
            ? "Selecione um veículo"
            : (() {
                final v = lista.firstWhere(
                  (e) => e.id == abastecimento.filtroVeiculoId,
                  orElse: () => lista.first,
                );
                return "${v.modelo} (${v.placa})";
              })();

        return PopupMenuButton<String?>(         
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),

          onSelected: (value) {
            abastecimento.setFiltroVeiculo(value);
          },

          itemBuilder: (context) {
            return [
              ...lista.map(
                (v) => PopupMenuItem(
                  value: v.id,
                  child: Text("${v.modelo} (${v.placa})"),
                ),
              ),
            ];
          },
        );
      },
    );
  }
}
