class UsuarioLoginViewModel {
  String email;
  String senha;

  UsuarioLoginViewModel({required this.email, required this.senha});

  Map<String, dynamic> toJson() {
    return {
      'Login': email,
      'Senha': senha,
    };
  }
}
