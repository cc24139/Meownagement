class EditTransacaoViewModel {
  int idTransacao;
  String nome;
  double quantiaDinheiro;
  DateTime dataCriacao;
  String feita;
  DateTime dataFinalizacao;
  int idClassificacao;
  int? idRecorrencia;
  int? idMeta;
  int? idCofrinho;

  EditTransacaoViewModel({
    required this.idTransacao,
    required this.nome,
    required this.quantiaDinheiro,
    required this.dataCriacao,
    this.feita = 'N',
    required this.dataFinalizacao,
    required this.idClassificacao,
    this.idRecorrencia,
    this.idMeta,
    this.idCofrinho,
  });

  Map<String, dynamic> toJson() => {
    'IdTransacao': idTransacao,
    'Nome': nome,
    'QuantiaDinheiro': quantiaDinheiro,
    'DataCriacao': dataCriacao.toIso8601String(),
    'Feita': feita,
    'DataFinalizacao': dataFinalizacao.toIso8601String(),
    'IdClassificacao': idClassificacao,
    'IdRecorrencia': idRecorrencia,
    'IdMeta': idMeta,
    'IdCofrinho': idCofrinho,
  };
}
