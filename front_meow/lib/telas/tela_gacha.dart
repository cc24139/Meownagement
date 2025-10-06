import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/MeowCoinWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';

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
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/doudouCat/doudouCatPequena.png"),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButtonWidget(
                            text: "Girar 1X",
                            onPressed: () {},
                            size: ButtonSize.muitoPequeno,
                            catColors: cores,
                          ),
                          const SizedBox(width: 16),
                          ElevatedButtonWidget(
                            text: "Girar 10X",
                            onPressed: () {},
                            size: ButtonSize.muitoPequeno,
                            catColors: cores,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Containers vazando para baixo
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: cores.corTerciaria, width: 2),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: cores.corTerciaria, width: 2),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: cores.corTerciaria, width: 1),
                          ),
                        ),
                      ],
                    ),
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
