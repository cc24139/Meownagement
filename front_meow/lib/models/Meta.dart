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
      idMeta: json['IdMeta'] ?? json['idMeta'],
      nome: json['Nome'] ?? json['nome'],
      gastoLimite: (json['GastoLimite'] ?? json['gastoLimite']) is num
          ? (json['GastoLimite'] ?? json['gastoLimite']).toDouble()
          : 0.0,
      qtsMoedas: json['QtsMoedas'] ?? json['qtsMoedas'],
      dataCriacao: DateTime.parse(json['DataCriacao'] ?? json['dataCriacao']),
      dataTermino: DateTime.parse(json['DataTermino'] ?? json['dataTermino']),
      feita: (json['Feita'] ?? json['feita']).toString(),
      idUsuario: json['IdUsuario'] ?? json['idUsuario'],
      idClassificacao: json['IdClassificacao'] ?? json['idClassificacao'],
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
