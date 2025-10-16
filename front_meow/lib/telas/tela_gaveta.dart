import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';

class TelaGaveta extends StatefulWidget {
  const TelaGaveta({super.key});

  @override
  State<TelaGaveta> createState() => _TelaGavetaState();
}

class _TelaGavetaState extends State<TelaGaveta> {
  CatColors cores = CatColors(paleta: 4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(Icons.menu, color: cores.complementar, size: 25),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
        drawer: Menulateralwidget(),
        backgroundColor: cores.corPrimaria,
    );
  }
}
