import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TelaTransacoes extends StatefulWidget {
  const TelaTransacoes({super.key});

  @override
  State<TelaTransacoes> createState() => _TelaTransacoesState();
}

class _TelaTransacoesState extends State<TelaTransacoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Planeje transações"),
            Row(
              children: [
                SvgPicture.asset("../../assets/icons/vetor_olho_aberto.svg"),
                Text("Saldo")
              ],
            ),
          ],
        ),
      ),
      
    );
  }
}
