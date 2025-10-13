class Gato {
  final int idGato;
  final String nome;
  final int raridade;
  final int codPaleta;
  final String nomeImagem;

  Gato({
    required this.idGato,
    required this.nome,
    required this.raridade,
    required this.codPaleta,
    required this.nomeImagem,
  });

  factory Gato.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'idGato': int idGato,
        'nome': String nome,
        'raridade': int raridade,
        'codPaleta': int codPaleta,
        'nomeImagem': String nomeImagem,
      } =>
        Gato(
          idGato: idGato,
          nome: nome,
          raridade: raridade,
          codPaleta: codPaleta,
          nomeImagem: nomeImagem,
        ),
      _ => throw Exception('Erro ao carregar gato'),
    };
  }

  Map<String, dynamic> toJson() => {
        'idGato': idGato,
        'nome': nome,
        'raridade': raridade,
        'codPaleta': codPaleta,
        'nomeImagem': nomeImagem,
      };
      
}