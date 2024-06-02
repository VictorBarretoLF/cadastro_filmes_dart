import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_filmes_sqflite");
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreatingDatabase
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
        faixaEtaria TEXT NOT NULL
      )
      """;
    await db.execute(sql);
  }

}