import 'package:flutter/material.dart';
import 'package:front_meow/colors/colors.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: GraficoConclusaoWidget(
            porcentagem: 75,
            catColors: CatColors(paleta: 2),
          ),
        ),
      ),
    ),
  );
}

class GraficoConclusaoWidget extends StatelessWidget {
  final int porcentagem;
  final CatColors catColors;
  const GraficoConclusaoWidget({
    super.key,
    required this.porcentagem,
    required this.catColors,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Stack(
          //Parte grafica
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                value: porcentagem / 100,
                strokeWidth: 15,
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
                  style: TextStyle(fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Londrina',
                  color: catColors.corSecundaria
                   ),
                ),
              ],
            ),
          ],
        ),
        Column(
        children: [
          SizedBox(height: 10),
          Padding(padding: EdgeInsets.only(top: 10)),
        ],
      
    )
    ],
    );
  }
}
