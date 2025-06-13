import 'package:controle_financeiro_pessoal/controllers/transacao_controller.dart';
import 'package:controle_financeiro_pessoal/models/categoria.dart';
import 'package:controle_financeiro_pessoal/models/transacao.dart';
import 'package:controle_financeiro_pessoal/view/adicionar_transacao_screen.dart';
import 'package:flutter/material.dart';

class DetalheCategoriaTela extends StatefulWidget {
  final Categoria categoria;

  const DetalheCategoriaTela({super.key, required this.categoria});

  @override
  State<DetalheCategoriaTela> createState() => _DetalheCategoriaTelaState();
}

class _DetalheCategoriaTelaState extends State<DetalheCategoriaTela> {
  final TransacaoControlador _controlador = TransacaoControlador();
  List<Transacao> _transacoes = [];

  @override
  void initState() {
    super.initState();
    _carregarTransacoes();
  }

  Future<void> _carregarTransacoes() async {
    final transacoes = await _controlador.listarTransacoesPorCategoria(widget.categoria.id!);
    setState(() {
      _transacoes = transacoes;
    });
  }

  double get totalReceitas => _transacoes
      .where((t) => t.tipo == 'receita')
      .fold(0.0, (soma, t) => soma + t.valor);

  double get totalDespesas => _transacoes
      .where((t) => t.tipo == 'despesa')
      .fold(0.0, (soma, t) => soma + t.valor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoria.nome)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Receitas: R\$ ${totalReceitas.toStringAsFixed(2)}'),
                Text('Despesas: R\$ ${totalDespesas.toStringAsFixed(2)}'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _transacoes.length,
              itemBuilder: (context, index) {
                final transacao = _transacoes[index];
                return ListTile(
                  title: Text(transacao.descricao),
                  subtitle: Text('${transacao.data} - ${transacao.tipo}'),
                  trailing: Text('R\$ ${transacao.valor.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AdicionarTransacaoTela(idCategoria: widget.categoria.id!),
            ),
          );
          _carregarTransacoes();
        },
      ),
    );
  }
}
