import 'package:controle_financeiro_pessoal/controllers/transacao_controller.dart';
import 'package:controle_financeiro_pessoal/models/transacao.dart';
import 'package:flutter/material.dart';

class AdicionarTransacaoTela extends StatefulWidget {
  final int idCategoria;

  const AdicionarTransacaoTela({super.key, required this.idCategoria});

  @override
  State<AdicionarTransacaoTela> createState() => _AdicionarTransacaoTelaState();
}

class _AdicionarTransacaoTelaState extends State<AdicionarTransacaoTela> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  String _tipoSelecionado = 'despesa';
  DateTime _dataSelecionada = DateTime.now();
  final _controlador = TransacaoControlador();

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final transacao = Transacao(
      idCategoria: widget.idCategoria,
      valor: double.parse(_valorController.text),
      descricao: _descricaoController.text,
      data: _dataSelecionada.toIso8601String().substring(0, 10),
      tipo: _tipoSelecionado,
    );

    await _controlador.adicionarTransacao(transacao);
    Navigator.pop(context);
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (data != null) {
      setState(() {
        _dataSelecionada = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Transação')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (valor) => valor == null || valor.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (valor) => valor == null || valor.isEmpty ? 'Campo obrigatório' : null,
              ),
              Row(
                children: [
                  const Text('Tipo: '),
                  DropdownButton<String>(
                    value: _tipoSelecionado,
                    items: const [
                      DropdownMenuItem(value: 'receita', child: Text('Receita')),
                      DropdownMenuItem(value: 'despesa', child: Text('Despesa')),
                    ],
                    onChanged: (valor) {
                      if (valor != null) {
                        setState(() => _tipoSelecionado = valor);
                      }
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Data: ${_dataSelecionada.toLocal().toString().split(' ')[0]}'),
                  TextButton(
                    onPressed: _selecionarData,
                    child: const Text('Selecionar Data'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar Transação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
