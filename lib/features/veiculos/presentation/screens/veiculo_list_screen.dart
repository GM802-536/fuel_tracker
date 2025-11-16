import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/controllers/veiculo_controller.dart';
import 'veiculo_form_screen.dart';

class VeiculoListScreen extends StatelessWidget {
  const VeiculoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VeiculoController(),
      child: const _VeiculoListView(),
    );
  }
}

class _VeiculoListView extends StatelessWidget {
  const _VeiculoListView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<VeiculoController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Veículos')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => VeiculoController(),
                child: const VeiculoFormScreen(),
              ),
            ),
          );
        },
      ),
      body: StreamBuilder(
        stream: controller.streamVeiculos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final veiculos = snapshot.data ?? [];

          if (veiculos.isEmpty) {
            return const Center(child: Text('Nenhum veículo cadastrado.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: veiculos.length,
            itemBuilder: (context, i) {
              final v = veiculos[i];

              return Card(
                child: ListTile(
                  title: Text('${v.modelo} (${v.ano})'),
                  subtitle: Text('${v.marca}   •   ${v.placa}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.delete(v.id),
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
