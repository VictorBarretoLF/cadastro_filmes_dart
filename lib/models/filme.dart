class Filme {
  int? id;
  String urlFilme;
  String titulo;
  String genero;
  String faixaEtaria;

  Filme({this.id, required this.urlFilme, required this.titulo, required this.genero, required this.faixaEtaria});

  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'],
      urlFilme: map['urlFilme'],
      titulo: map['titulo'],
      genero: map['genero'],
      faixaEtaria: map['faixaEtaria'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'urlFilme': urlFilme,
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
