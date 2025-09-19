class CodEmail {
  final int idCode;
  final String code;
  final String email;
  final DateTime tempoExp;
  final String nome;
  final String? biografia;
  final String senha;

  CodEmail({
    required this.idCode,
    required this.code,
    required this.email,
    required this.tempoExp,
    required this.nome,
    required this.senha,
    required this.biografia
  });

  factory CodEmail.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'IdCode': int idCode, 
        'Code': String code,
        'Email': String email,
        'TempoExp': DateTime tempoExp,
        'Nome': String nome,
        'Senha': String senha,
        'Biografia': String biografia
      } => 
        CodEmail(
          idCode: idCode,
          code: code,
          email: email,
          tempoExp: tempoExp,
          nome: nome,
          senha: senha,
          biografia: biografia
        ),
      _ => throw Exception('Erro ao carregar codigo email'),
    };
  }
}
