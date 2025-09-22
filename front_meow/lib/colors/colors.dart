import 'package:flutter/material.dart';

class CatColors {
  String paleta;
  late Color primary;
  late Color secondary;
  late Color tertiary;

  CatColors({required this.paleta}) {
    switch (paleta.toLowerCase()) {
      case '':
        primary   = Color(0xFF374151);
        secondary = Color(0xFFF97316);
        tertiary  = Color(0xFFFACC15);
        break;
      default:
        primary   = Colors.white;
        secondary = Colors.white;
        tertiary  = Colors.white;
    }
  }

  Color get corPrimaria => primary;
  Color get corSecundaria => secondary;
  Color get corTerciaria => tertiary;
}
