import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instancia = DBHelper._interno();
  factory DBHelper() => _instancia;

  DBHelper._interno();

  Database? _banco;

  Future<Database> get banco async {
    if (_banco != null) return _banco!;
    _banco = await _inicializarBanco();
    return _banco!;
  }

  Future<Database> _inicializarBanco() async {
    final caminho = await getDatabasesPath();
    final caminhoCompleto = join(caminho, 'controle_financeiro.db');

    return openDatabase(
      caminhoCompleto,
      version: 1,
      onCreate: _criarTabelas,
    );
  }

  Future<void> _criarTabelas(Database db, int versao) async {
    await db.execute('''
      CREATE TABLE categorias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE transacoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idCategoria INTEGER,
        valor REAL,
        descricao TEXT,
        data TEXT,
        tipo TEXT,
        FOREIGN KEY (idCategoria) REFERENCES categorias (id)
      )
    ''');
  }
}
