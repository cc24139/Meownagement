class UsuarioViewModel {
  final int id;
  final String nome;
  final String email;
  final String pontos;
  final String saldo;

  UsuarioViewModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.pontos,
    required this.saldo,
  });

  factory UsuarioViewModel.fromJson(Map<String, dynamic> json) {
    return UsuarioViewModel(
      id: json['idUsuario'],
      nome: json['nome'],
      email: json['email'],
      pontos: json['pontos'],
      saldo: json['saldo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': id,
      'nome': nome,
      'email': email,
      'pontos': pontos,
      'saldo': saldo,
    };
  }
}
