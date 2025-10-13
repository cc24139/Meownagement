import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/colors/colors.dart';

VoidCallback ronaldo = () => print("Botão pressionado");

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButtonWidget(
            text: "Clique aqui",
            onPressed: ronaldo,
            size: ButtonSize.grande,
            catColors: CatColors(paleta: 2),
          ),
        ),
      ),
    ),
  );
}

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonSize size;
  final CatColors catColors;

  const ElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.size,
    required this.catColors,
  });

  double? _getButtonWidth() {
    print("Entrou no getButtonWidth com size: $size");
    switch (size) {
      case ButtonSize.muitoPequeno:
        return 25;
      case ButtonSize.pequeno:
        return 50;
      case ButtonSize.medio:
        return 100;
      case ButtonSize.grande:
        return 250;
      default:
        return 150;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [_buildButton()]);
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(catColors.corSecundaria),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(_getButtonWidth() ?? 150, 55),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
