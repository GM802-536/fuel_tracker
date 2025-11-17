import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../veiculos/presentation/controllers/veiculo_controller.dart';
import '../../presentation/controllers/abastecimento_controller.dart';

class FiltroVeiculoDropdown extends StatefulWidget {
  const FiltroVeiculoDropdown({super.key});

  @override
  State<FiltroVeiculoDropdown> createState() => _FiltroVeiculoDropdownState();
}

class _FiltroVeiculoDropdownState extends State<FiltroVeiculoDropdown> {
  String? veiculoIdSelecionado;

  @override
  Widget build(BuildContext context) {
    final veiculoCtrl = context.watch<VeiculoController>();

    return StreamBuilder(
      stream: veiculoCtrl.streamVeiculos(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final veiculos = snapshot.data!;

        return DropdownButton<String>(
          value: veiculoIdSelecionado,
          hint: const Text("Filtrar"),
          underline: const SizedBox(),
          onChanged: (value) {
            setState(() {
              veiculoIdSelecionado = value;
            });

            context.read<AbastecimentoController>().setFiltroVeiculo(value);
          },
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text("Todos"),
            ),
            ...veiculos.map(
              (v) => DropdownMenuItem(
                value: v.id,
                child: Text("${v.modelo} (${v.placa})"),
              ),
            ),
          ],
        );
      },
    );
  }
}
