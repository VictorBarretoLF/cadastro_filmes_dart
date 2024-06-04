import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste/models/filme.dart';
import 'package:teste/services/filme_service.dart';
import 'package:teste/view/cadastrar_filme.dart';
import 'package:teste/view/filme_detalhes.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _filmesService = FilmeService();
  List<Filme> _filmesList = [];

  @override
  void initState() {
    super.initState();
    getAllFilmes();
  }

  getAllFilmes() async {
    var filmes = await _filmesService.readFilmes();
    setState(() {
      _filmesList = filmes;
    });
  }

  _deleteFilme(int? id) async {
    if(id == null) return;
    _filmesService.deletarFilme(id);
  }

  void _showOptionsMenu(BuildContext context, Filme filme) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Exibir Dados'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FilmeDetalhes(filmeId: filme.id!),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Alterar'),
              onTap: () {
                print("alterar dados ${filme.id}");
              },
            ),
          ],
        );
      },
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Equipe:'),
          content: Text('Victor Barreto'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Catalogo Filmes",
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: Icon(Icons.info_outline, color: Colors.white),
              onPressed: () {
                print('Info ícone clicado');
                _showInfoDialog();
              },
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 16),
        child: ListView.builder(
          itemCount: _filmesList.length,
          itemBuilder: (context, index) {
            final filme = _filmesList[index];
            return Dismissible(
              key: Key(filme.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _deleteFilme(filme.id?.toInt());
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: GestureDetector(
                onTap: () {
                  print('CLICADO EM ID: ${filme.id}');
                  _showOptionsMenu(context, filme);
                },
                child: Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Row(
                      children: [
                        Image.network(
                          filme.urlFilme,
                          width: 100,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return const Text('Invalid URL');
                          },
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filme.titulo,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Gênero: ${filme.genero}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Faixa Etária: ${filme.faixaEtaria}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CadastrarFilme()));
          await getAllFilmes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
