import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_filmes_sqflite");
    var database = await openDatabase(
      path,
      version: 3,
      onCreate: _onCreatingDatabase,
      onUpgrade: _onUpgradeDatabase,
    );
    return database;
  }

  _onCreatingDatabase(Database db, int version) async {
    var sql =  """
      CREATE TABLE filmes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        urlFilme TEXT NOT NULL,
        titulo TEXT NOT NULL,
        genero TEXT NOT NULL,
        faixaEtaria TEXT NOT NULL,
        rating REAL NOT NULL DEFAULT 0,
        ano TEXT NOT NULL DEFAULT 'Desconhecido',
        descricao TEXT NOT NULL,
        duracao TEXT NOT NULL
      )
      """;
    await db.execute(sql);
  }

  _onUpgradeDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      var columns = await db.rawQuery('PRAGMA table_info(filmes)');
      List<String> columnNames = columns.map((col) => col['name'] as String).toList();

      if (!columnNames.contains('rating')) {
        await db.execute("ALTER TABLE filmes ADD COLUMN rating REAL NOT NULL DEFAULT 0");
      }

      if (!columnNames.contains('ano')) {
        await db.execute("ALTER TABLE filmes ADD COLUMN ano TEXT NOT NULL DEFAULT 'Desconhecido'");
      }

      if (!columnNames.contains('descricao')) {
        await db.execute("ALTER TABLE filmes ADD COLUMN descricao TEXT NOT NULL");
      }

      if (!columnNames.contains('duracao')) {
        await db.execute("ALTER TABLE filmes ADD COLUMN duracao TEXT NOT NULL");
      }
    }
  }
}
