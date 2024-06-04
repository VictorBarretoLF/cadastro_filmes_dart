import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teste/models/filme.dart';
import 'package:teste/services/filme_service.dart';

class FilmeDetalhes extends StatefulWidget {
  final int filmeId;

  FilmeDetalhes({required this.filmeId});

  @override
  _FilmeDetalhesState createState() => _FilmeDetalhesState();
}

class _FilmeDetalhesState extends State<FilmeDetalhes> {
  final _filmesService = FilmeService();
  late Filme _filme;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFilmeDetails();
  }

  _fetchFilmeDetails() async {
    var filme = await _filmesService.getFilmeById(widget.filmeId);
    setState(() {
      _filme = filme;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Detalhes",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.network(
                _filme.urlFilme,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Text('Invalid URL'),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _filme.titulo,
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(_filme.ano,
                    style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _filme.genero,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                      FontWeight.w400,
                      color: Colors.grey
                  ),
                ),
                Text(
                  _filme.faixaEtaria,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                      FontWeight.w400,
                      color: Colors.grey
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _filme.duracao,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                      FontWeight.w400,
                      color: Colors.grey
                  ),
                ),
                RatingBarIndicator(
                  rating: _filme.rating,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(_filme.descricao,
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
