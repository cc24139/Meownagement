import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/MeowCoinWidget.dart';
import 'package:front_meow/colors/colors.dart';

class TelaGacha extends StatefulWidget {
  const TelaGacha({super.key});

  @override
  State<TelaGacha> createState() => _TelaGachaState();
}

class _TelaGachaState extends State<TelaGacha> {
  CatColors cores = CatColors(paleta: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cores.primaria,
      appBar: AppBar(
        backgroundColor: cores.primaria,
        centerTitle: true,
        title: MeowcoinWidget(saldo: 350.75),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nome do Banner",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'LondrinaShadow',
                color: cores.tercearia,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: cores.tercearia,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/gato1.png"),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Botão 1"),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Botão 2"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
