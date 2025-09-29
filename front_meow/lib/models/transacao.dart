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
      idTransacao: json['idTransacao'],
      nome: json['nome'],
      quantiaDinheiro: json['quantiaDinheiro'],
      dataCriacao: DateTime.parse(json['dataCriacao']),
      feita: json['feita'],
      dataFinalizacao: DateTime.parse(json['dataFinalizacao']),
      saldoAtual: json['saldoAtual'],
      idUsuario: json['idUsuario'],
      idClassificacao: json['idClassificacao'],
      idRecorrencia: json['idRecorrencia'],
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
