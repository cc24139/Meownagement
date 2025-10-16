class Classificacao {
  final int idClassificacao;
  final String tipo;

  Classificacao({required this.idClassificacao, required this.tipo});

  factory Classificacao.fromJson(Map<String, dynamic> json) {
    final id = json['IdClassificacao'] ?? json['idClassificacao'];
    final tipo = json['Tipo'] ?? json['tipo'];
    if (id is int && tipo is String) {
      return Classificacao(idClassificacao: id, tipo: tipo);
    }
    throw Exception('Erro ao carregar classificação');
  }
}
