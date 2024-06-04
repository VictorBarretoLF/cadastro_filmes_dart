import 'package:teste/models/filme.dart';
import 'package:teste/repositories/repository.dart';

class FilmeService {
  final Repository _repository = Repository();

  Future<int> salvarFilme(Filme filme) async {
    return await _repository.insertData('filmes', filme.toMap());
  }

  Future<List<Filme>> readFilmes() async {
    final List<Map<String, dynamic>> filmesMap = await _repository.readData('filmes');
    return filmesMap.map((map) => Filme.fromMap(map)).toList();
  }

  Future<void> deletarFilme(int id) async {
    await _repository.deleteData("filmes", id);
  }

  Future<Filme> getFilmeById(int id) async {
    final List<Map<String, dynamic>> filmeMap = await _repository.readDataById('filmes', id);
    return Filme.fromMap(filmeMap.first);
  }

}
