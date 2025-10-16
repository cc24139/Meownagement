import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';

class TelaCriarMeta extends StatefulWidget {
  const TelaCriarMeta({super.key});

  @override
  State<TelaCriarMeta> createState() => _TelaCriarMetaState();
}

class _TelaCriarMetaState extends State<TelaCriarMeta> {
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
                      icon: Icon(
                        Icons.menu,
                        color: cores.complementar,
                        size: 25,
                      ),
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
