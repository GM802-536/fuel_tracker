import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/validator.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../presentation/controllers/veiculo_controller.dart';

class VeiculoFormScreen extends StatefulWidget {
  const VeiculoFormScreen({super.key});

  @override
  State<VeiculoFormScreen> createState() => _VeiculoFormScreenState();
}

class _VeiculoFormScreenState extends State<VeiculoFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final modelo = TextEditingController();
  final marca = TextEditingController();
  final placa = TextEditingController();
  final ano = TextEditingController();
  String tipoCombustivel = 'Gasolina';

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<VeiculoController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Novo Veículo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: modelo,
                validator: (v) => Validator.requiredText(v, 'o modelo'),
                decoration: const InputDecoration(labelText: 'Modelo'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: marca,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: (v) => Validator.requiredText(v, 'a marca'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: placa,
                decoration: const InputDecoration(labelText: 'Placa'),
                validator: Validator.placa,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: ano,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ano'),
                validator: Validator.ano,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: tipoCombustivel,
                items: const [
                  DropdownMenuItem(value: 'Gasolina', child: Text('Gasolina')),
                  DropdownMenuItem(value: 'Etanol', child: Text('Etanol')),
                  DropdownMenuItem(value: 'Diesel', child: Text('Diesel')),
                ],
                onChanged: (v) => tipoCombustivel = v!,
                decoration: const InputDecoration(
                  labelText: 'Tipo de combustível',
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Salvar',
                  loading: controller.loading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final ok = await controller.addVeiculo(
                        modelo: modelo.text,
                        marca: marca.text,
                        placa: placa.text,
                        ano: int.parse(ano.text),
                        tipoCombustivel: tipoCombustivel,
                      );

                      if (ok && mounted) Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
