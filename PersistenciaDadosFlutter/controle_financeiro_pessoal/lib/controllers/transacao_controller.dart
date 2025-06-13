import 'package:controle_financeiro_pessoal/models/transacao.dart';
import 'package:controle_financeiro_pessoal/services/db_helper.dart';

class TransacaoControlador {
  final DBHelper _dbHelper = DBHelper();

  Future<int> adicionarTransacao(Transacao transacao) async {
    final db = await _dbHelper.banco;
    return await db.insert('transacoes', transacao.toMap());
  }

  Future<List<Transacao>> listarTransacoesPorCategoria(int idCategoria) async {
    final db = await _dbHelper.banco;
    final resultado = await db.query(
      'transacoes',
      where: 'idCategoria = ?',
      whereArgs: [idCategoria],
    );
    return resultado.map((e) => Transacao.fromMap(e)).toList();
  }
}
