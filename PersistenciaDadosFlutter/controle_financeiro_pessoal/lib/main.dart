import 'package:controle_financeiro_pessoal/view/lista_categorias_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle Financeiro',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const ListaCategoriasTela(),
    );
  }
}
