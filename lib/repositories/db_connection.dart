import 'package:sqflite/sqflite.dart';

class DbConnection {
  static final DbConnection? _instance = DbConnection._();
  Database? db;

  static String seedsCategory =
      "insert into category (category_name, category_thumb) "
      "VALUES "
      "('Bebidas', 'assets/thumbs/bebidas.png'), "
      "('Biscoitos', 'assets/thumbs/biscoitos.png'), "
      "('Cafeinados', 'assets/thumbs/cafes.png'), "
      "('Carnes', 'assets/thumbs/carnes.png'), "
      "('Frutas', 'assets/thumbs/frutas.png'), "
      "('Fungos', 'assets/thumbs/fungos.png'), "
      "('Lácteos', 'assets/thumbs/lacteos.png'), "
      "('Legumes', 'assets/thumbs/legumes.png'), "
      "('Raizes', 'assets/thumbs/raizes.png'), "
      "('Sementes', 'assets/thumbs/sementes.png'), "
      "('Vegetais', 'assets/thumbs/vegetais.png'), "
      "('Verduras', 'assets/thumbs/verduras.png'), "
      "('Doces', 'assets/thumbs/doces.png') ";

  DbConnection._();

  factory DbConnection() {
    return _instance!;
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> onCreate(Database db, int version) async {
    db.execute(
        "CREATE TABLE category ( category_id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,	category_name TEXT  NOT NULL, category_thumb TEXT  NOT NULL)");
    db.execute(
        "CREATE TABLE product ( id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL, category_id INTEGER  NOT NULL, custom_thumb_base64 TEXT,  value REAL, latitude REAL, longitude REAL, FOREIGN KEY (category_id) REFERENCES category(category_id))");
    db.execute(seedsCategory);
  }

  Future<void> conn() async {
    return await getDatabasesPath().then((androidPath) async {
      String path = androidPath + '/example.db';
      db = await openDatabase(path,
          version: 1, onCreate: onCreate, onConfigure: _onConfigure);
    });
  }
}
