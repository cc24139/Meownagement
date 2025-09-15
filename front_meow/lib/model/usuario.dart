class Usuario {
  final int idUsuario;
  final String nome;
  final String email;
  final double saldo;
  final int pontos;
  final String biografia;

  Usuario({
    required this.idUsuario,
    required this.nome,
    required this.email,
    required this.saldo,
    required this.pontos,
    required this.biografia,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'idUsuario': int idUsuario,
        'nome': String nome,
        'email': String email,
        'saldo': double saldo,
        'pontos': int pontos,
        'biografia': String biografia,
      } =>
        Usuario(
          idUsuario: idUsuario,
          nome: nome,
          email: email,
          saldo: saldo,
          pontos: pontos,
          biografia: biografia,
        ),
      _ => throw Exception('Erro ao carregar usuario'),
    };
  }
}
