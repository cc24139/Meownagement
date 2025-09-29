class LoginDiario {
  final int idUsuario;
  final int numSequencia;
  final DateTime ultimoLogin;
  final int idLogin;

  LoginDiario({
    required this.idUsuario,
    required this.numSequencia,
    required this.ultimoLogin,
    required this.idLogin,
  });

  factory LoginDiario.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'idUsuario': int idUsuario,
        'numSequencia': int numSequencia,
        'ultimoLogin': String ultimoLogin,
        'idLogin': int idLogin,
      } =>
        LoginDiario(
          idUsuario: idUsuario,
          numSequencia: numSequencia,
          ultimoLogin: DateTime.parse(ultimoLogin),
          idLogin: idLogin,
        ),
      _ => throw Exception('Erro ao carregar loginDiario'),
    };
  }
}
