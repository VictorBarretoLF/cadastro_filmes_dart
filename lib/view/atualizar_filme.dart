import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/services.dart';
import 'package:teste/models/filme.dart';
import 'package:teste/services/filme_service.dart';

class AtualizarFilme extends StatefulWidget {
  final int filmeId;

  AtualizarFilme({required this.filmeId});

  @override
  _AtualizarFilmeState createState() => _AtualizarFilmeState();
}

class _AtualizarFilmeState extends State<AtualizarFilme> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _urlDaImagem = TextEditingController();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _duracaoController = TextEditingController();
  String _selectedClassificacao = 'Livre';
  double _rating = 3.0;

  var _filmeService = FilmeService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFilmeDetails();
  }

  _fetchFilmeDetails() async {
    var filme = await _filmeService.getFilmeById(widget.filmeId);
    setState(() {
      _urlDaImagem.text = filme.urlFilme;
      _tituloController.text = filme.titulo;
      _generoController.text = filme.genero;
      _anoController.text = filme.ano;
      _selectedClassificacao = filme.faixaEtaria;
      _rating = filme.rating;
      _duracaoController.text = filme.duracao;
      _descricaoController.text = filme.descricao;
      _isLoading = false;
    });
  }

  _atualizarFilme() async {
    if (_formKey.currentState!.validate()) {
      var filme = Filme(
        id: widget.filmeId,
        titulo: _tituloController.text,
        urlFilme: _urlDaImagem.text,
        genero: _generoController.text,
        faixaEtaria: _selectedClassificacao,
        rating: _rating,
        ano: _anoController.text,
        descricao: _descricaoController.text,
        duracao: _duracaoController.text,
      );

      var result = await _filmeService.atualizarFilme(filme);
      if (result != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sucesso"),
              content: Text("O filme foi atualizado com sucesso!"),
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
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Atualizar Filme",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _urlDaImagem,
                decoration: InputDecoration(
                  labelText: 'URL da Imagem',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _generoController,
                decoration: InputDecoration(
                  labelText: 'Gênero',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _duracaoController,
                decoration: InputDecoration(
                  labelText: 'Duração',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text("Faixa etária"),
                  SizedBox(width: 16.0), // Espaço de 16 pixels
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedClassificacao,
                      isExpanded: true, // Adiciona esta linha para expandir o dropdown
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text("Nota: "),
                  Expanded(
                    child: RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _anoController,
                decoration: InputDecoration(
                  labelText: 'Ano',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Cor vermelha para o botão de cancelar
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _atualizarFilme,
                    child: Text('Atualizar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
