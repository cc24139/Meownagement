class CreateMetasViewModel {
  String nome;
  double gastoLimite;
  int idClassificacao;
  DateTime dataCriacao;
  DateTime dataTermino;
  String feita;

  CreateMetasViewModel({
    required this.nome,
    required this.gastoLimite,
    required this.idClassificacao,
    required this.dataCriacao,
    required this.dataTermino,
    required this.feita,
  });

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'gastoLimite': gastoLimite,
    'idClassificacao': idClassificacao,
    'dataCriacao': dataCriacao.toIso8601String(),
    'dataTermino': dataTermino.toIso8601String(),
    'feita': feita,
  };

  factory CreateMetasViewModel.fromJson(Map<String, dynamic> json) {
    return CreateMetasViewModel(
      nome: json['nome'],
      gastoLimite: (json['gastoLimite'] as num).toDouble(),
      idClassificacao: json['idClassificacao'],
      dataCriacao: DateTime.parse(json['dataCriacao']),
      dataTermino: DateTime.parse(json['dataTermino']),
      feita: json['feita'],
    );
  }
}
