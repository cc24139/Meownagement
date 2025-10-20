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
              clipper: BolasTelaUsuarios(),
              child: Container(
                height: 1400 * 0.1, // Ocupa 25% da altura da tela
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

class BolasTelaUsuarios extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0, 0);

    path.quadraticBezierTo(
      size.width * 0.08, // Ponto de controle X
      size.height * 0.6, // Ponto de controle Y (puxa a curva para baixo)
      size.width * 0.2,  // Ponto final X (o "vale" da intersecção)
      size.height * 0.1, // Ponto final Y
    );

    path.quadraticBezierTo(
      size.width * 0.3, 
      size.height * 0.6, 
      size.width * 0.4,   
      size.height * 0.1, 
    );

    path.quadraticBezierTo(
      size.width * 0.51, 
      size.height * 0.6, 
      size.width * 0.6,  
      size.height * 0, 
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
