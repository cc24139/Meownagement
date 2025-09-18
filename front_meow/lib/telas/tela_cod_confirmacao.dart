import 'package:flutter/material.dart';

class TelaCodConfirmacao extends StatefulWidget {
  const TelaCodConfirmacao({super.key});

  @override
  State<TelaCodConfirmacao> createState() => _TelaCodConfirmacaoState();
}

class _TelaCodConfirmacaoState extends State<TelaCodConfirmacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirmação por Email",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Londrina",
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            //Fazer
          ],
        ),
      ),
    );
  }
}
