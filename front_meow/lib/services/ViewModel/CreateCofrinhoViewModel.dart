class CreateCofrinhoViewModel {
  double economia;
  DateTime dataCriacao;
  DateTime dataTermino;
  String feita;
  String nome;
  int idClassificacao;

  CreateCofrinhoViewModel({
    required this.economia,
    required this.dataCriacao,
    required this.dataTermino,
    required this.feita,
    required this.nome,
    required this.idClassificacao,
  });

  Map<String, dynamic> toJson() => {
    'economia': economia,
    'dataCriacao': dataCriacao.toIso8601String(),
    'dataTermino': dataTermino.toIso8601String(),
    'feita': feita,
    'nome': nome,
    'idClassificacao': idClassificacao,
  };

  factory CreateCofrinhoViewModel.fromJson(Map<String, dynamic> json) {
    return CreateCofrinhoViewModel(
      economia: (json['economia'] as num).toDouble(),
      dataCriacao: DateTime.parse(json['dataCriacao']),
      dataTermino: DateTime.parse(json['dataTermino']),
      feita: json['feita'],
      nome: json['nome'],
      idClassificacao: json['idClassificacao'],
    );
  }
}
