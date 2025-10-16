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
      idCofrinho: json['IdCofrinho'] ?? json['idCofrinho'],
      economia: (json['Economia'] ?? json['economia']) is num
          ? (json['Economia'] ?? json['economia']).toDouble()
          : 0.0,
      qtsMoedas: json['QtsMoedas'] ?? json['qtsMoedas'],
      dinheiroEconomizado:
          (json['DinheiroEconomizado'] ?? json['dinheiroEconomizado']) is num
          ? (json['DinheiroEconomizado'] ?? json['dinheiroEconomizado'])
                .toDouble()
          : 0.0,
      dataCriacao: DateTime.parse(json['DataCriacao'] ?? json['dataCriacao']),
      dataTermino: DateTime.parse(json['DataTermino'] ?? json['dataTermino']),
      feita: (json['Feita'] ?? json['feita']).toString(),
      nome: json['Nome'] ?? json['nome'],
      idUsuario: json['IdUsuario'] ?? json['idUsuario'],
      idClassificacao: json['IdClassificacao'] ?? json['idClassificacao'],
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
