class MetaCofrinhoTransacao {
  int idRel;
  int? idMeta;
  int? idCofrinho;
  int idTransacao;

  MetaCofrinhoTransacao({
    required this.idRel,
    this.idMeta,
    this.idCofrinho,
    required this.idTransacao,
  });

  factory MetaCofrinhoTransacao.fromJson(Map<String, dynamic> json) {
    return MetaCofrinhoTransacao(
      idRel: json['idRel'],
      idMeta: json['idMeta'],
      idCofrinho: json['idCofrinho'],
      idTransacao: json['idTransacao'],
    );
  }
}
