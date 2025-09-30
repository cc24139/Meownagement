import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: BarraWidgets(
            corBarra: Colors.blue,
            nomeBarra: "Exemplo",
            valorBarraVertical: 100,
          ),
        ),
      ),
    ),
  );
}

class BarraWidgets extends StatelessWidget {
  final Color corBarra;
  final String nomeBarra;
  final double valorBarraVertical; //acho que nao precisa de valor na horizontal

  const BarraWidgets({
    super.key,
    required this.corBarra,
    required this.nomeBarra,
    required this.valorBarraVertical,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(nomeBarra),
        SizedBox(height: 5),
        Container(
          width: 30,
          height: valorBarraVertical,
          color: corBarra,
        ),
      ],
    );
  }
}
