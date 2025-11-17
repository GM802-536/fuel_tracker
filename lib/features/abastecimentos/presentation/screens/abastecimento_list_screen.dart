import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/abastecimento_controller.dart';
import 'abastecimento_form_screen.dart';
import '../../../veiculos/presentation/controllers/veiculo_controller.dart';
import '../widgets/abastecimento_filtro_veiculo_dropdown.dart';

class AbastecimentoListScreen extends StatelessWidget {
  const AbastecimentoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AbastecimentoController()),
        ChangeNotifierProvider(create: (_) => VeiculoController()),
      ],
      child: const _AbastecimentoListView(),
    );
  }
}

class _AbastecimentoListView extends StatelessWidget {
  const _AbastecimentoListView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AbastecimentoController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Abastecimentos"),
        actions: const [FiltroVeiculoDropdown()],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => AbastecimentoController(),
                  ),
                  ChangeNotifierProvider(create: (_) => VeiculoController()),
                ],
                child: const AbastecimentoFormScreen(),
              ),
            ),
          );
        },
      ),
      body: StreamBuilder(
        stream: controller.streamAbastecimentos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final dados = snapshot.data!;
          if (dados.isEmpty) {
            return const Center(
              child: Text('Nenhum abastecimento cadastrado.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: dados.length,
            itemBuilder: (context, i) {
              final a = dados[i];
              return Card(
                child: ListTile(
                  title: Text(
                    "${a.quilometragem} km • ${a.quantidadeLitros} L",
                  ),
                  subtitle: Text(
                    "R\$ ${a.valorPago.toStringAsFixed(2)} — ${a.consumo.toStringAsFixed(2)} km/L",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.delete(a.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
