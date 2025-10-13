import 'package:front_meow/models/gato.dart';

class PerfilViewModel {
  int idUsuario;
  String nome;
  String email;
  String biografia;
  int pontos;
  double saldo;
  Gato gatoEquipado;

  PerfilViewModel({
    required this.idUsuario,
    required this.nome,
    required this.email,
    required this.biografia,
    required this.pontos,
    required this.saldo,
    required this.gatoEquipado,
  });

  factory PerfilViewModel.fromJson(Map<String, dynamic> json) {
    return PerfilViewModel(
      idUsuario: json['idUsuario'],
      nome: json['nome'],
      email: json['email'],
      biografia: json['biografia'],
      pontos: json['pontos'],
      saldo: (json['saldo'] as num).toDouble(),
      gatoEquipado: Gato.fromJson(json['gatoEquipado']),
    );
  }

  Map<String, dynamic> toJson() => {
    'idUsuario': idUsuario,
    'nome': nome,
    'email': email,
    'biografia': biografia,
    'pontos': pontos,
    'saldo': saldo,
    'gatoEquipado': gatoEquipado.toJson(),
  };

  Map<String, dynamic> fromJson() {
    return {
      'idUsuario': idUsuario,
      'nome': nome,
      'email': email,
      'biografia': biografia,
      'pontos': pontos,
      'saldo': saldo,
      'gatoEquipado': gatoEquipado.toJson(),
    };
  }
}