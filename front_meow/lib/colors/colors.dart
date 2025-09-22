import 'package:flutter/material.dart';

class CatColors {
  String paleta;
  late Color primaria;
  late Color secundaria;
  late Color tercearia;
  late Color complementar;

  CatColors({required this.paleta}) {
    switch (paleta.toLowerCase()) {
      case '':
        primaria     = Color(0xFF374151);
        secundaria   = Color(0xFFF97316);
        tercearia    = Color(0xFFFACC15);
        complementar = Colors.white;
        break;
      default:
        primaria     = Colors.white;
        secundaria   = Colors.white;
        tercearia    = Colors.white;
        complementar = Colors.black;
    }
  }

  Color get corPrimaria => primaria;
  Color get corSecundaria => secundaria;
  Color get corTerciaria => tercearia;
  Color get corComplementar => complementar;
}
