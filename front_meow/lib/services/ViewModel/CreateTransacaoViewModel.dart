class CreateTransacaoViewModel {
  String nome;
  double quantiaDinheiro;
  String feita;
  // SaldoAtual is optional on client; server sets it, but we keep optional in case
  double? saldoAtual;
  DateTime dataFinalizacao;
  int idClassificacao;
  int? idRecorrencia;
  int? idMeta;
  int? idCofrinho;

  CreateTransacaoViewModel({
    required this.nome,
    required this.quantiaDinheiro,
    this.feita = 'N',
    this.saldoAtual,
    required this.dataFinalizacao,
    required this.idClassificacao,
    this.idRecorrencia,
    this.idMeta,
    this.idCofrinho,
  });

  Map<String, dynamic> toJson() => {
    'Nome': nome,
    'QuantiaDinheiro': quantiaDinheiro,
    'Feita': feita,
    if (saldoAtual != null) 'SaldoAtual': saldoAtual,
    'DataFinalizacao': dataFinalizacao.toIso8601String(),
    'IdClassificacao': idClassificacao,
    'IdRecorrencia': idRecorrencia,
    'IdMeta': idMeta,
    'IdCofrinho': idCofrinho,
  };
}
