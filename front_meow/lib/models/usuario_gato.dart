class UsuarioGato {
  final int idUsuario;
  final int idGato;
  final int copias;
  final String equipado;

  UsuarioGato({
    required this.idUsuario,
    required this.idGato,
    required this.copias,
    required this.equipado,
  });

  factory UsuarioGato.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'idUsuario': int idUsuario,
        'idGato': int idGato,
        'copias': int copias,
        'equipado': String equipado,
      } =>
        UsuarioGato(
          idUsuario: idUsuario,
          idGato: idGato,
          copias: copias,
          equipado: equipado,
        ),
      _ => throw Exception('Erro ao carregar usuarioGato'),
    };
  }
}