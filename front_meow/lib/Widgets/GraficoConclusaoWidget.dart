import 'package:flutter/material.dart';
import 'package:front_meow/colors/colors.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: GraficoConclusaoWidget(
            porcentagem: 75,
            titulo: "Ecnomizar no Seu Miguel",
            subtitulo: "Economia de um pão de queijo por dia",
            todo: 2540,
            catColors: CatColors(paleta: 'EL'),
          ),
        ),
      ),
    ),
  );
}

class GraficoConclusaoWidget extends StatelessWidget {
  final int porcentagem;
  final String titulo;
  final String subtitulo;
  final double todo; //valor de um todo tipo 2540 todo
  final CatColors catColors;
  const GraficoConclusaoWidget({
    super.key,
    required this.porcentagem,
    required this.titulo,
    required this.subtitulo,
    required this.todo,
    required this.catColors,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Stack(
          //Parte grafica
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: porcentagem / 100,
                strokeWidth: 10,
                backgroundColor: catColors.corPrimaria,
                valueColor: AlwaysStoppedAnimation<Color>(catColors.corSecundaria),
              ),
            ),
            Column(
              //Textos do grafico
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$porcentagem%',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'de $todo',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        Column(
        children: [
          SizedBox(height: 10),
          Text(
            subtitulo,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
        ],
      
    )
    ],
    );
  }
}
