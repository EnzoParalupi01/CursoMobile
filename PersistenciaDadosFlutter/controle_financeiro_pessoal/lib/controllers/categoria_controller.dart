import 'package:controle_financeiro_pessoal/models/categoria.dart';
import 'package:controle_financeiro_pessoal/services/db_helper.dart';

class CategoriaControlador {
  final DBHelper _dbHelper = DBHelper();

  Future<int> adicionarCategoria(Categoria categoria) async {
    final db = await _dbHelper.banco;
    return await db.insert('categorias', categoria.toMap());
  }

  Future<List<Categoria>> listarCategorias() async {
    final db = await _dbHelper.banco;
    final resultado = await db.query('categorias');
    return resultado.map((e) => Categoria.fromMap(e)).toList();
  }
}
