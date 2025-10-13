import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/Tools/BolasSize.dart';
import 'package:front_meow/colors/colors.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: BolasTools(
            catColors: CatColors(paleta: 2),
            elipse: false,
            size: Bolassize.media,
            textBall: "Economia",
          ),
        ),
      ),
    ),
  );
}

class BolasTools extends StatelessWidget {
  final CatColors catColors;
  final bool elipse;
  final Bolassize size;
  final Object? textBall;
  final Color? color; // opção para sobrescrever a cor da bola

  const BolasTools({
    super.key,
    required this.catColors,
    required this.elipse,
    required this.size,
    required this.textBall,
    this.color,
  });

  int getWidth() {
    if (elipse) {
      switch (size) {
        case Bolassize.pequena:
          return 75;
        case Bolassize.media:
          return 150;
        case Bolassize.grande:
          return 300;
        default:
          return 30;
      }
    }
    switch (size) {
      case Bolassize.pequena:
        return 30;
      case Bolassize.media:
        return 60;
      case Bolassize.grande:
        return 120;
      default:
        return 30;
    }
  }

  int getHeight() {
    if (elipse) {
      switch (size) {
        case Bolassize.pequena:
          return 50;
        case Bolassize.media:
          return 100;
        case Bolassize.grande:
          return 200;
        default:
          return 30;
      }
    }
    switch (size) {
      case Bolassize.pequena:
        return 30;
      case Bolassize.media:
        return 60;
      case Bolassize.grande:
        return 120;
      default:
        return 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = getWidth().toDouble();
    final double height = getHeight().toDouble();

    // Font size proportional to the ball width, clamped for readability
    final double fontSize = (width * 0.35).clamp(8.0, 28.0);

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Bola de fundo
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color ?? catColors.secundaria,
              borderRadius: elipse
                  ? BorderRadius.all(Radius.elliptical(width / 2, height / 2))
                  : BorderRadius.circular(360),
            ),
          ),

          // Texto por cima da bola
          if (textBall != null && textBall.toString().isNotEmpty)
            Center(
              child: Text(
                textBall.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
