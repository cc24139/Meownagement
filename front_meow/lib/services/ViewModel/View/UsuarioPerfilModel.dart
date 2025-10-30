import 'package:front_meow/models/gato.dart';

class UsuarioPerfilModel {
  int? idUsuario;
  String? nome;
  String? biografia;
  int? pontos;
  Gato? gatoEquipado;
  List<Gato>? gatosDesbloqueados;

  UsuarioPerfilModel({
    this.nome,
    this.biografia,
    this.gatoEquipado,
    this.gatosDesbloqueados,
    this.pontos,
  });

  factory UsuarioPerfilModel.fromJson(Map<String, dynamic> json) {
    return UsuarioPerfilModel(
      nome: json['nome'],
      biografia: json['biografia'],
      gatoEquipado: json['gatoEquipado'] != null
          ? Gato.fromJson(json['gatoEquipado'])
          : null,
      gatosDesbloqueados: json['gatosDesbloqueados'] != null
          ? (json['gatosDesbloqueados'] as List)
                .map((i) => Gato.fromJson(i))
                .toList()
          : null,
      pontos: json['pontos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'biografia': biografia,
      'pontos': pontos,
      'gatoEquipado': gatoEquipado?.toJson(),
      'gatosDesbloqueados': gatosDesbloqueados
          ?.map((gato) => gato.toJson())
          .toList(),
    };
  }
}
