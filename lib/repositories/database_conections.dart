import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_filmes_sqflite");
    var database = await openDatabase(
      path,
      version: 2,
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
        rating REAL NOT NULL,
        ano TEXT NOT NULL
      )
      """;
    await db.execute(sql);
  }

  _onUpgradeDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE filmes ADD COLUMN rating REAL NOT NULL DEFAULT 0");
      await db.execute("ALTER TABLE filmes ADD COLUMN ano TEXT NOT NULL DEFAULT 'Desconhecido'");
    }
  }

}