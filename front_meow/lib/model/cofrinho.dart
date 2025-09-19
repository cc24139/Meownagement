class Cofrinho {
  int idCofrinho;
  double economia;
  int qtsMoedas;
  double dinheiroEconomizado;
  DateTime dataCriacao;
  DateTime dataTermino;
  String feita;
  String nome;
  int idUsuario;
  int idClassificacao;

  Cofrinho({
    required this.idCofrinho,
    required this.economia,
    required this.qtsMoedas,
    required this.dinheiroEconomizado,
    required this.dataCriacao,
    required this.dataTermino,
    required this.feita,
    required this.nome,
    required this.idUsuario,
    required this.idClassificacao,
  });

  factory Cofrinho.fromJson(Map<String, dynamic> json) {
    return Cofrinho(
      idCofrinho: json['idCofrinho'],
      economia: json['economia'].toDouble(),
      qtsMoedas: json['qtsMoedas'],
      dinheiroEconomizado: json['dinheiroEconomizado'].toDouble(),
      dataCriacao: DateTime.parse(json['dataCriacao']),
      dataTermino: DateTime.parse(json['dataTermino']),
      feita: json['feita'],
      nome: json['nome'],
      idUsuario: json['idUsuario'],
      idClassificacao: json['idClassificacao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCofrinho': idCofrinho,
      'economia': economia,
      'qtsMoedas': qtsMoedas,
      'dinheiroEconomizado': dinheiroEconomizado,
      'dataCriacao': dataCriacao.toIso8601String(),
      'dataTermino': dataTermino.toIso8601String(),
      'feita': feita,
      'nome': nome,
      'idUsuario': idUsuario,
      'idClassificacao': idClassificacao,
    };
  }
}
