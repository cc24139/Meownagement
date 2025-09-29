import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';

VoidCallback ronaldo = () => print("Botão pressionado");

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: ElevatedButtonWidget(
          text: "Clique aqui",
          onPressed: ronaldo,
          size: ButtonSize.pequeno,
        ),
      ),
    ),
  ));
}

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonSize size;

  const ElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.size,
  });

  double? _getButtonWidth() {
    switch (size) {
      case ButtonSize.pequeno:
        return 30;
      case ButtonSize.medio:
        return 100;
      case ButtonSize.grande:
        return 450;
      default:
        return 150;
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(),
        SizedBox(height: _getButtonWidth() ),
      ],
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 153, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
      
  }
}

