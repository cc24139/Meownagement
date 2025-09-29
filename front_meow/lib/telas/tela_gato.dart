import 'package:flutter/material.dart';
import 'package:front_meow/colors/colors.dart';

class TelaGato extends StatefulWidget {
  const TelaGato({super.key});

  @override
  State<TelaGato> createState() => _TelaGatoState();
}

class _TelaGatoState extends State<TelaGato> {
  CatColors cores = CatColors(paleta: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: cores.corPrimaria,
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Container(height: 2, color: cores.complementar)),
              const SizedBox(width: 10),
              Text(
                "Ronaldo",
                style: TextStyle(
                  fontFamily: "Londrina",
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: cores.complementar,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: Container(height: 2, color: cores.complementar)),
            ],
          ),
        ),
      ),
    );
  }
}
