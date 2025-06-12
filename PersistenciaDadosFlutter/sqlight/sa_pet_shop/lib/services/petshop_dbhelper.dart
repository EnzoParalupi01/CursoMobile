import 'package:sa_pet_shop/models/consulta_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/pet_model.dart';

class PetShopDBHelper {
  static Database? _database;
  static final PetShopDBHelper _instance = PetShopDBHelper._internal();

  PetShopDBHelper._internal();
  factory PetShopDBHelper() => _instance;

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "petshop.db");

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        raca TEXT NOT NULL,
        nome_dono TEXT NOT NULL,
        telefone_dono TEXT NOT NULL
      );
    """);
    print("Tabela pets criada");

    await db.execute("""
      CREATE TABLE IF NOT EXISTS consultas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pet_id INTEGER NOT NULL,
        data_hora TEXT NOT NULL,
        tipo_servico TEXT NOT NULL,
        observacao TEXT NOT NULL,
        FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE
      );
    """);
    print("Tabela consultas criada");
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // CRUD - PETS
  Future<int> insertPet(Pet pet) async {
    final db = await database;
    return db.insert("pets", pet.toMap());
  }

  Future<List<Pet>> getPets() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("pets");
    return maps.map((e) => Pet.fromMap(e)).toList();
  }

  Future<Pet?> getPetById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "pets",
      where: "id=?",
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return null;
    } else {
      return Pet.fromMap(maps.first);
    }
  }

  Future<int> deletePet(int id) async {
    final db = await database;
    return await db.delete("pets", where: "id=?", whereArgs: [id]);
  }

  // CRUD - CONSULTAS
  Future<int> insertConsulta(Consulta consulta) async {
    final db = await database;
    return await db.insert("consultas", consulta.toMap());
  }

  Future<List<Consulta>> getConsultasForPet(int petId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "consultas",
      where: "pet_id=?",
      whereArgs: [petId],
    );
    return maps.map((e) => Consulta.fromMap(e)).toList();
  }

  Future<int> deleteConsulta(int id) async {
    final db = await database;
    return db.delete("consultas", where: "id=?", whereArgs: [id]);
  }
}
