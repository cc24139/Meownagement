import 'package:front_meow/models/gato.dart';

class UsuarioPerfilModel {
  int? idUsuario;
  String? nome;
  String? biografia;
  int? pontos;
  Gato? gatoEquipado;
  List<Gato>? gatosDesbloqueados;

  UsuarioPerfilModel({
    this.idUsuario,
    this.nome,
    this.biografia,
    this.gatoEquipado,
    this.gatosDesbloqueados,
    this.pontos,
  });

  factory UsuarioPerfilModel.fromJson(Map<String, dynamic> json) {
    return UsuarioPerfilModel(
      idUsuario: json['idUsuario'],
      nome: json['nome'],
      biografia: json['biografia'],
      pontos: json['pontos'],
      gatoEquipado: json['gatoEquipado'] != null
          ? Gato.fromJson(json['gatoEquipado'])
          : null,
      gatosDesbloqueados: json['gatosDesbloqueados'] != null
          ? List<Gato>.from(
              json['gatosDesbloqueados']
                  .map((gato) => Gato.fromJson(gato)),
            )
          : null,
        
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
