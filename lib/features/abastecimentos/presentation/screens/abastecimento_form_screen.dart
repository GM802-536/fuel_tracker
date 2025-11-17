import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../veiculos/presentation/controllers/veiculo_controller.dart';
import '../../presentation/controllers/abastecimento_controller.dart';
import '../../../../common/widgets/custom_button.dart';

class AbastecimentoFormScreen extends StatefulWidget {
  const AbastecimentoFormScreen({super.key});

  @override
  State<AbastecimentoFormScreen> createState() =>
      _AbastecimentoFormScreenState();
}

class _AbastecimentoFormScreenState extends State<AbastecimentoFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final litros = TextEditingController();
  final valor = TextEditingController();
  final km = TextEditingController();
  final observacao = TextEditingController();
  String tipoCombustivel = 'Gasolina';
  String? veiculoId;

  @override
  Widget build(BuildContext context) {
    final abastecimento = context.watch<AbastecimentoController>();
    final veiculos = Provider.of<VeiculoController>(context, listen: false);


    return Scaffold(
      appBar: AppBar(title: const Text("Novo Abastecimento")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              StreamBuilder(
                stream: veiculos.streamVeiculos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();

                  final list = snapshot.data!;
                  if (list.isEmpty) {
                    return const Text("Cadastre um veículo primeiro.");
                  }

                  return DropdownButtonFormField(
                    decoration:
                        const InputDecoration(labelText: "Veículo"),
                    value: veiculoId,
                    items: list
                        .map((v) => DropdownMenuItem(
                              value: v.id,
                              child: Text("${v.modelo} (${v.placa})"),
                            ))
                        .toList(),
                    onChanged: (v) => veiculoId = v,
                    validator: (v) =>
                        v == null ? "Selecione o veículo" : null,
                  );
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: km,
                decoration:
                    const InputDecoration(labelText: "Quilometragem atual"),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? "Informe a quilometragem" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: litros,
                decoration:
                    const InputDecoration(labelText: "Litros abastecidos"),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? "Informe a quantidade" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: valor,
                decoration:
                    const InputDecoration(labelText: "Valor pago (R\$)"),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? "Informe o valor" : null,
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField(
                decoration: const InputDecoration(
                    labelText: "Tipo de combustível"),
                value: tipoCombustivel,
                items: const [
                  DropdownMenuItem(value: 'Gasolina', child: Text('Gasolina')),
                  DropdownMenuItem(value: 'Etanol', child: Text('Etanol')),
                  DropdownMenuItem(value: 'Diesel', child: Text('Diesel')),
                ],
                onChanged: (v) => tipoCombustivel = v!,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: observacao,
                maxLines: 3,
                decoration:
                    const InputDecoration(labelText: "Observação (opcional)"),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: "Registrar",
                  loading: abastecimento.loading,
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final ok = await abastecimento.addAbastecimento(
                      data: DateTime.now(),
                      litros: double.parse(litros.text),
                      valor: double.parse(valor.text),
                      km: double.parse(km.text),
                      tipoCombustivel: tipoCombustivel,
                      veiculoId: veiculoId!,
                      observacao: observacao.text.isEmpty
                          ? null
                          : observacao.text,
                    );

                    if (ok && mounted) Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
