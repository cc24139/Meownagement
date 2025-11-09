import 'package:flutter/material.dart';

class CatColors {
  int paleta;
  late Color primaria;
  late Color secundaria;
  late Color tercearia;
  late Color complementar;

  CatColors({required this.paleta}) {
    switch (paleta) {
      case 1:
        primaria = Color(0xFFF8EDEB);
        secundaria = Color(0xFFFFB5A7);
        tercearia = Color(0xFFFCD5CE);
        complementar = Colors.black;
      case 2:
        primaria = Color(0xFFECF0F1);
        secundaria = Color(0xFF2C3E50);
        tercearia = Color(0xFF6B95BE);
        complementar = Colors.black;
      case 3:
        primaria = Color(0xFFF5DEB3); 
        secundaria = Color(0xFF166534);
        tercearia = Color(0xFFEA580C);
        complementar = const Color.fromARGB(255, 0, 0, 0);
      case 4:
        primaria     = Color(0xFF374151);
        secundaria   = Color(0xFFF97316);
        tercearia    = Color(0xFFFACC15);
        complementar = Colors.white;
        break;
      case 5:
        primaria     = Color(0xFFF3F4F6);
        secundaria   = Color(0xFFEF4444);
        tercearia    = Color(0xFF374151);
        complementar = Colors.black;
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
