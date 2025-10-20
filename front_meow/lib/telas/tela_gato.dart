//import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';

class TelaGato extends StatefulWidget {
  const TelaGato({super.key});

  @override
  State<TelaGato> createState() => _TelaGatoState();
}

class _TelaGatoState extends State<TelaGato> {
  CatColors cores = CatColors(paleta: 4);
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
              Expanded(child: Container(height: 3, color: cores.complementar)),
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
              Expanded(child: Container(height: 3, color: cores.complementar)),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (_) =>
                        Icon(Icons.pets, size: 50, color: cores.complementar),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "../../assets/images/doudouCat/doudouCatGrande.jpg",
                          width: 300,
                          height: 300,
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Dados",
                          style: TextStyle(
                            color: cores.corTerciaria,
                            fontSize: 24,
                          ),
                        ),
                      ),

                      SizedBox(height: 5),
                      Text(
                        "Posse do gato: ${12.3.toString()}%",
                        style: TextStyle(color: cores.corTerciaria),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Uso do gato: ${1.23.toString()}%",
                        style: TextStyle(color: cores.corTerciaria),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Numero de cópias: ${123.toString()}",
                        style: TextStyle(color: cores.corTerciaria),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 400,
                  child: Divider(color: cores.complementar, thickness: 1),
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Paleta de cores: ",
                        style: TextStyle(color: cores.tercearia, fontSize: 20),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: cores.complementar,
                            width: 2,
                          ),
                          gradient: LinearGradient(
                            begin: AlignmentGeometry.centerLeft,
                            end: AlignmentGeometry.centerRight,
                            colors: [
                              cores.tercearia,
                              cores.secundaria,
                              cores.primaria,
                            ],
                            stops: [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
        backgroundColor: cores.corPrimaria,
        drawer: Menulateralwidget(),
    );
  }
}
