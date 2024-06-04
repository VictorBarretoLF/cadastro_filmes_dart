class Filme {
  int? id;
  String urlFilme;
  String titulo;
  String genero;
  String faixaEtaria;
  double rating;
  String ano;

  Filme({
    this.id,
    required this.urlFilme,
    required this.titulo,
    required this.genero,
    required this.faixaEtaria,
    required this.rating,
    required this.ano
  });

  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'],
      urlFilme: map['urlFilme'],
      titulo: map['titulo'],
      genero: map['genero'],
      faixaEtaria: map['faixaEtaria'],
      rating: map['rating'],
      ano: map['ano'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'urlFilme': urlFilme,
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'rating': rating,
      'ano': ano
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
