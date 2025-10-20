import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
       body: Stack(
        children: [
          // Widget da forma de CIMA
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: BolasBaixoTelaInicial(),
              child: Container(
                height: 1400 * 0.25, // Ocupa 25% da altura da tela
                width: 600,
                color: Colors.blue, // Cor de fundo para visualização
              ),
            ),
          ),
        ],
      ),
    ),
    ),
  );
}

class BolasBaixoTelaInicial extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Move para o ponto inicial da curva na esquerda.
    path.moveTo(0, size.height * 0.75);

    // Curva do "primeiro círculo" (esquerda)
    // O ponto de controle está bem para cima, criando um pico.
    path.quadraticBezierTo(
      size.width * 0.21, // Ponto de controle X
      size.height * 0.5, // Ponto de controle Y (puxa a curva para cima)
      size.width * 0.45,  // Ponto final X
      size.height * 0.65, // Ponto final Y
    );

    // Curva do "segundo círculo" (direita)
    // O ponto de controle está mais baixo, criando um vale suave.
    path.quadraticBezierTo(
      size.width * 0.68, // Ponto de controle X
      size.height * 0.2, // Ponto de controle Y (puxa a curva para baixo)
      size.width,        // Ponto final X
      size.height * 0.32, // Ponto final Y
    );

    // Linhas para completar a forma no canto inferior direito
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}