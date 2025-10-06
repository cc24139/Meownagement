import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/Tools/BolasSize.dart';
import 'package:front_meow/Widgets/Tools/BolasTools.dart';
import 'package:front_meow/colors/colors.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: TitleTelaWidget(
            title: "Hello",
            subtitle: "World",
            catColors: new CatColors(paleta: 'EL'),
          ),
        ),
      ),
    ),
  );
}

class TitleTelaWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final CatColors catColors;

  const TitleTelaWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.catColors,
  });

  List<Widget> _generateBackgroundBalls() {
    // Gera um conjunto de BolasTools com base nos caracteres do título
    return List<Widget>.generate(
      title.length,
      (i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: BolasTools(
          catColors: catColors,
          elipse: true,
          size: Bolassize.pequena,
          textBall: title[i],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final balls = _generateBackgroundBalls();

    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Bolas ao fundo com opacidade baixa
          IgnorePointer(
            ignoring: true,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: balls,
              ),
            ),
          // Texto por cima das bolas
        ],
      ),
    );
  }
}
