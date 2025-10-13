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
            catColors: new CatColors(paleta: 2),
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
      (i) => Transform.translate(
        offset: Offset(i * -12.0, 0), // Sobreposição horizontal negativa menor
        child: BolasTools(
          catColors: catColors,
          elipse: true,
          size: Bolassize.pequena,
          textBall: title[i],
          color: catColors.corSecundaria,
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
          Opacity(
            opacity: 0.6,
            child: IgnorePointer(
              ignoring: true,
              child: Stack(alignment: Alignment.center, children: balls),
            ),
          ),
          // Texto por cima das bolas
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              if (subtitle.isNotEmpty) ...[
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
