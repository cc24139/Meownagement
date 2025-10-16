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
    final id = json['IdGato'] ?? json['idGato'];
    final nome = json['Nome'] ?? json['nome'];
    final raridade = json['Raridade'] ?? json['raridade'];
    final codPaleta = json['CodPaleta'] ?? json['codPaleta'];
    final nomeImagem = json['NomeImagem'] ?? json['nomeImagem'];
    if (id is int &&
        nome is String &&
        raridade is int &&
        codPaleta is int &&
        nomeImagem is String) {
      return Gato(
        idGato: id,
        nome: nome,
        raridade: raridade,
        codPaleta: codPaleta,
        nomeImagem: nomeImagem,
      );
    }
    throw Exception('Erro ao carregar gato');
  }

  Map<String, dynamic> toJson() => {
    'idGato': idGato,
    'nome': nome,
    'raridade': raridade,
    'codPaleta': codPaleta,
    'nomeImagem': nomeImagem,
  };
}
