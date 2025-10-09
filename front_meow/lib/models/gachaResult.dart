import 'package:front_meow/models/gato.dart';

class GachaResult {
  final List<Gato> gatos;
  final int raridadeMaisAlta;
  final int rollsTotais;

  GachaResult({
    required this.gatos,
    required this.raridadeMaisAlta,
    required this.rollsTotais,
  });
}
