class Transacao {
  int idTransacao;
  String nome;
  double quantiaDinheiro;
  DateTime dataCriacao;
  String feita;
  DateTime dataFinalizacao;
  double saldoAtual;
  int idUsuario;
  int idClassificacao;
  int? idRecorrencia;

  Transacao({
    required this.idTransacao,
    required this.nome,
    required this.quantiaDinheiro,
    required this.dataCriacao,
    required this.feita,
    required this.dataFinalizacao,
    required this.saldoAtual,
    required this.idUsuario,
    required this.idClassificacao,
    this.idRecorrencia,
  });

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(
      idTransacao: json['IdTransacao'] ?? json['idTransacao'],
      nome: json['Nome'] ?? json['nome'],
      quantiaDinheiro:
          (json['QuantiaDinheiro'] ?? json['quantiaDinheiro']) is num
          ? (json['QuantiaDinheiro'] ?? json['quantiaDinheiro']).toDouble()
          : 0.0,
      dataCriacao: DateTime.parse(json['DataCriacao'] ?? json['dataCriacao']),
      feita: (json['Feita'] ?? json['feita']).toString(),
      dataFinalizacao: DateTime.parse(
        json['DataFinalizacao'] ?? json['dataFinalizacao'],
      ),
      saldoAtual: (json['SaldoAtual'] ?? json['saldoAtual']) is num
          ? (json['SaldoAtual'] ?? json['saldoAtual']).toDouble()
          : 0.0,
      idUsuario: json['IdUsuario'] ?? json['idUsuario'],
      idClassificacao: json['IdClassificacao'] ?? json['idClassificacao'],
      idRecorrencia: json['IdRecorrencia'] ?? json['idRecorrencia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idTransacao': idTransacao,
      'nome': nome,
      'quantiaDinheiro': quantiaDinheiro,
      'dataCriacao': dataCriacao.toIso8601String(),
      'feita': feita,
      'dataFinalizacao': dataFinalizacao.toIso8601String(),
      'saldoAtual': saldoAtual,
      'idUsuario': idUsuario,
      'idClassificacao': idClassificacao,
      'idRecorrencia': idRecorrencia,
    };
  }
}
