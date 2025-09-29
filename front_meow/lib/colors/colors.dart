import 'package:flutter/material.dart';

class CatColors {
  String paleta;
  late Color primaria;
  late Color secundaria;
  late Color tercearia;
  late Color complementar;

  CatColors({required this.paleta}) {
    switch (paleta.toUpperCase()) {
      case 'DA':
        primaria = Color(0xFFF8EDEB);
        secundaria = Color(0xFFFFB5A7);
        tercearia = Color(0xFFFCD5CE);
        complementar = Colors.white;
      case 'NI':
        primaria = Color(0xFFECF0F1);
        secundaria = Color(0xFF2C3E50);
        tercearia = Color(0xFF34495E);
        complementar = Colors.white;
      case 'EL':
        primaria = Color(0xFF166534);
        secundaria = Color.fromARGB(255, 223, 140, 140);
        tercearia = Color(0xFFEA580C);
        complementar = Colors.white;
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
