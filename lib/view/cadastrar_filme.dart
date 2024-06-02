import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste/models/filme.dart';
import 'package:teste/services/filme_service.dart';

class CadastrarFilme extends StatefulWidget {

  @override
  State<CadastrarFilme> createState() => _CadastrarFilmeState();
}

class _CadastrarFilmeState extends State<CadastrarFilme> {
  final TextEditingController _urlDaImagem = TextEditingController();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  String _selectedClassificacao = 'Livre';

  var _filmeService = FilmeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cadastrar Filme",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlDaImagem,
              decoration: InputDecoration(
                labelText: 'URL da Imagem',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16.0),
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16.0),
            TextField(
              controller: _generoController,
              decoration: InputDecoration(
                labelText: 'Gênero',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16.0),
            Row(
              children: [
                Text("Faixa etária"),
                SizedBox(width: 16.0), // Espaço de 16 pixels
                DropdownButton<String>(
                  value: _selectedClassificacao,
                  items: <String>['Livre', '10', '12', '14', '16', '18']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedClassificacao = newValue!;
                    });
                  },
                ),
              ],
            ),

            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop();
                  },
                  child: Text('Cancelar',),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Red color for cancel button
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var filme = Filme(
                      titulo: _tituloController.text,
                      urlFilme: _urlDaImagem.text,
                      genero: _generoController.text,
                      faixaEtaria: _selectedClassificacao,
                    );

                    var result = await _filmeService.salvarFilme(filme);
                    if (result != null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Sucesso"),
                            content: Text("O filme foi criado com sucesso!"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      ).then((value) {
                        Navigator.of(context).pop(); // Dar pop na tela
                      });
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
