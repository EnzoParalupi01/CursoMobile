import 'package:controle_financeiro_pessoal/controllers/categoria_controller.dart';
import 'package:controle_financeiro_pessoal/models/categoria.dart';
import 'package:controle_financeiro_pessoal/view/detalhe_categoria_screen.dart';
import 'package:flutter/material.dart';

class ListaCategoriasTela extends StatefulWidget {
  const ListaCategoriasTela({super.key});

  @override
  State<ListaCategoriasTela> createState() => _ListaCategoriasTelaState();
}

class _ListaCategoriasTelaState extends State<ListaCategoriasTela> {
  final CategoriaControlador _controlador = CategoriaControlador();
  final TextEditingController _nomeController = TextEditingController();

  List<Categoria> _categorias = [];

  @override
  void initState() {
    super.initState();
    _carregarCategorias();
  }

  Future<void> _carregarCategorias() async {
    final categorias = await _controlador.listarCategorias();
    setState(() {
      _categorias = categorias;
    });
  }

  Future<void> _adicionarCategoria() async {
    if (_nomeController.text.isEmpty) return;
    final novaCategoria = Categoria(nome: _nomeController.text);
    await _controlador.adicionarCategoria(novaCategoria);
    _nomeController.clear();
    _carregarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nova Categoria',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _adicionarCategoria,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _categorias.length,
              itemBuilder: (context, index) {
                final categoria = _categorias[index];
                return ListTile(
                  title: Text(categoria.nome),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalheCategoriaTela(categoria: categoria),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
