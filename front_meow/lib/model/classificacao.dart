class Classificacao {
  final int idClassificacao;
  final String tipo;

  Classificacao({
    required this.idClassificacao,
    required this.tipo,
  });

  factory Classificacao.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'IdClassificacao': int idClassificacao,
        'Tipo': String tipo,
      } =>
        Classificacao(
          idClassificacao: idClassificacao,
          tipo: tipo,
        ),
      _ => throw Exception('Erro ao carregar classificação'),
    };
  }
}