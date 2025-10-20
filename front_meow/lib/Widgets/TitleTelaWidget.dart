import 'package:flutter/material.dart';
//import 'package:front_meow/Widgets/Tools/BolasSize.dart';
//import 'package:front_meow/Widgets/Tools/BolasTools.dart';
import 'package:front_meow/colors/colors.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: TitleTelaWidget(
            titulo: "Planeje Transações",
            tamanho: 50,
            qtsBolas: 11,
            overlapFactor: 0.45,
            tamanhoFonte: 38.0,
            cores: CatColors(paleta: 2),
          ),
        ),
      ),
    ),
  );
}

class TitleTelaWidget extends StatelessWidget {
  final String titulo;
  final double tamanho;
  final int qtsBolas;
  final double overlapFactor;
  final double tamanhoFonte;
  final CatColors cores;

  const TitleTelaWidget({
    Key? key,
    required this.titulo,
    required this.tamanho, // Diâmetro de cada bolha
    required this.qtsBolas,    // Número de bolhas na fileira
    required this.overlapFactor, // Fator de sobreposição (0.6 = 60%)
    required this.tamanhoFonte,     // Tamanho da fonte
    required this.cores,
  }) : super(key: key);

  // Helper widget para criar uma única bolha
  Widget _buildBubble() {
    return Container(
      width: tamanho,
      height: tamanho,
      decoration: BoxDecoration(
        color: cores.corSecundaria,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- Esta é a lógica corrigida ---

    // 1. Calcular o quanto cada bolha avança (o "passo")
    // Se a bolha tem 40 e o overlap é 0.6 (60%), 
    // ela "consome" 40 * 0.6 = 24 pixels da bolha anterior.
    // O "passo" (step) é o quanto ela avança: 40 * (1 - 0.6) = 16 pixels.
    final double step = tamanho * (1 - overlapFactor); // ex: 16.0

    // 2. Calcular a largura visual total
    // A primeira bolha ocupa 'tamanho' (40)
    // As (qtsBolas - 1) bolhas restantes ocupam 'step' (16) cada.
    // ex: 40 + (12 * 16) = 40 + 192 = 232
    final double totalVisualWidth = tamanho + (step * (qtsBolas - 1));
    final double totalVisualHeight = tamanho;

    // 3. Usamos um SizedBox para dar ao Stack um tamanho definido.
    // Sem isso, o Stack tentaria ser infinito.
    return SizedBox(
      width: totalVisualWidth,
      height: totalVisualHeight,
      child: Stack(
        // O alinhamento central irá centralizar o Texto automaticamente
        alignment: Alignment.center,
        children: [
          // 1. As bolhas no fundo
          // Geramos a lista de bolhas e as posicionamos
          ...List.generate(qtsBolas, (index) {
            // A posição 'left' de cada bolha é o índice * o "passo"
            final double leftPosition = index * step; // 0, 16, 32, 48...
            
            return Positioned(
              left: leftPosition,
              top: 0,
              bottom: 0,
              child: _buildBubble(),
            );
          }),

          // 2. O título no topo
          // Ele será centralizado no Stack (que tem 232px de largura)
          Text(
            titulo,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: tamanhoFonte,
              fontFamily: 'Londrina',
            ),
          ),
        ],
      ),
    );
  }
}