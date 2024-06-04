class Filme {
  int? id;
  String urlFilme;
  String titulo;
  String genero;
  String faixaEtaria;
  double rating;
  String ano;
  String descricao;
  String duracao;

  Filme({
    this.id,
    required this.urlFilme,
    required this.titulo,
    required this.genero,
    required this.faixaEtaria,
    required this.rating,
    required this.ano,
    required this.descricao,
    required this.duracao
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
      descricao: map['descricao'],
      duracao: map['duracao'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'urlFilme': urlFilme,
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'rating': rating,
      'ano': ano,
      'descricao': descricao,
      'duracao': duracao,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
