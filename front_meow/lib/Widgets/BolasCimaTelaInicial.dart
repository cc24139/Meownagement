import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
       body: Stack(
        children: [
          // Widget da forma de CIMA
          Positioned(
            top: 0,
            left: 0,
            child: ClipPath(
              clipper: BolasCimaTelaInicial(),
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

class BolasCimaTelaInicial extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Começa no canto superior esquerdo e desce para o início da primeira curva.
    path.lineTo(0, size.height * 0.75);

    // Curva do "primeiro círculo" (esquerda)
    // O ponto de controle está mais baixo, criando um arco côncavo.
    path.quadraticBezierTo(
      size.width * 0.4, // Ponto de controle X
      size.height * 0.9, // Ponto de controle Y (puxa a curva para baixo)
      size.width * 0.55,  // Ponto final X (o "vale" da intersecção)
      size.height * 0.35, // Ponto final Y
    );

    // Curva do "segundo círculo" (direita)
    // O ponto de controle está bem mais alto (fora da tela, teoricamente),
    // criando um arco convexo mais acentuado.
    path.quadraticBezierTo(
      size.width * 0.77, // Ponto de controle X
      size.height * 0.62, // Ponto de controle Y (puxa a curva para cima)
      size.width,        // Ponto final X
      size.height * 0.45, // Ponto final Y
    );

    // Sobe para o canto superior direito para fechar a forma
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
