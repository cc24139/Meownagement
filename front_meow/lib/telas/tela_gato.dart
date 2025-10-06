import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (_) => Icon(
                  Icons.pets,
                  size: 50,
                  color: cores.secundaria,
                ))
              ),
              SizedBox(height: 20),
              Image.asset("../../assets/images/doudouCat/doudouCatGrande.jpg", width: 400, height: 400),
              SizedBox(height: 20),
              Center(
                child: Text("Dados"),
              ),
              SizedBox(height: 5),
              Text("Posse do gato: ${12.3.toString()}%"),
              Text("Uso do gato: ${1.23.toString()}%"),
              Text("Numero de cópias: ${123.toString()}")
            ],
          ),
        ),
      ),
      backgroundColor: cores.corPrimaria,
    );
  }
}
