class Metas {
  int idMeta;
  String nome;
  double gastoLimite;
  int qtsMoedas;
  DateTime dataCriacao;
  DateTime dataTermino;
  String feita;
  int idUsuario;
  int idClassificacao;

  Metas({
    required this.idMeta,
    required this.nome,
    required this.gastoLimite,
    required this.qtsMoedas,
    required this.dataCriacao,
    required this.dataTermino,
    required this.feita,
    required this.idUsuario,
    required this.idClassificacao,
  });

  factory Metas.fromJson(Map<String, dynamic> json) {
    return Metas(
      idMeta: json['idMeta'],
      nome: json['nome'],
      gastoLimite: (json['gastoLimite'] as num).toDouble(),
      qtsMoedas: json['qtsMoedas'],
      dataCriacao: DateTime.parse(json['dataCriacao']),
      dataTermino: DateTime.parse(json['dataTermino']),
      feita: json['feita'],
      idUsuario: json['idUsuario'],
      idClassificacao: json['idClassificacao'],
    );
  }

  Map<String, dynamic> toJson() => {
    'idMeta': idMeta,
    'nome': nome,
    'gastoLimite': gastoLimite,
    'qtsMoedas': qtsMoedas,
    'dataCriacao': dataCriacao.toIso8601String(),
    'dataTermino': dataTermino.toIso8601String(),
    'feita': feita,
    'idUsuario': idUsuario,
    'idClassificacao': idClassificacao,
  };
}
