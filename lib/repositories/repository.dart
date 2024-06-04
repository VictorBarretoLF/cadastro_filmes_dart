import 'package:teste/repositories/database_conections.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  final DatabaseConnection _databaseConnection;

  Repository() : _databaseConnection = DatabaseConnection();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _databaseConnection.setDatabase();
    return _database!;
  }

  Future<int> insertData(String table, Map<String, dynamic> data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> readData(String table) async {
    var connection = await database;
    return await connection.query(table);
  }

  Future<int> deleteData(String table, int id) async {
    var connection = await database;
    return await connection.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> readDataById(String table, int id) async {
    var connection = await database;
    return await connection.query(table, where: 'id = ?', whereArgs: [id]);
  }

}
