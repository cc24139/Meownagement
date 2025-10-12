// lib/animations/cat_animations.dart
import 'package:flutter/material.dart';

class GachaAnimations {
  // Animação de salto genérica
  static Widget buildJumpingAnimation({
    required Widget child,
    required AnimationController controller,
    Curve curve = Curves.elasticOut,
    double beginScale = 0.0,
    double endScale = 1.0,
  }) {
    final animation = Tween<double>(
      begin: beginScale,
      end: endScale,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
    ));

    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }

  // Animação de salto com delay sequencial
  static Widget buildJumpingAnimationWithDelay({
    required Widget child,
    required AnimationController controller,
    required int index,
    required int totalItems,
    Duration delay = const Duration(milliseconds: 100),
    Curve curve = Curves.elasticOut,
    double beginScale = 0.0,
    double endScale = 1.0,
  }) {
    final delayedAnimation = Tween<double>(
      begin: beginScale,
      end: endScale,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          (index * delay.inMilliseconds) / (totalItems * delay.inMilliseconds + 500),
          (index * delay.inMilliseconds + 500) / (totalItems * delay.inMilliseconds + 500),
          curve: curve,
        ),
      ),
    );

    return ScaleTransition(
      scale: delayedAnimation,
      child: child,
    );
  }

  // Layout para múltiplos gatos com animação sequencial
  static Widget buildMultipleCatsLayout({
    required List<Widget> catWidgets,
    required AnimationController controller,
    int catsPerRow = 5,
    Duration delay = const Duration(milliseconds: 100),
  }) {
    // Divide a lista em linhas
    List<List<Widget>> rows = [];
    for (int i = 0; i < catWidgets.length; i += catsPerRow) {
      int end = (i + catsPerRow < catWidgets.length) ? i + catsPerRow : catWidgets.length;
      rows.add(catWidgets.sublist(i, end));
    }

    return Column(
      children: rows.asMap().entries.map((rowEntry) {
        int rowIndex = rowEntry.key;
        List<Widget> rowCats = rowEntry.value;
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowCats.asMap().entries.map((catEntry) {
            int catIndexInRow = catEntry.key;
            Widget catWidget = catEntry.value;
            
            // Calcula o índice global do gato
            int globalIndex = rowIndex * catsPerRow + catIndexInRow;
            
            return buildJumpingAnimationWithDelay(
              controller: controller,
              index: globalIndex,
              totalItems: catWidgets.length,
              delay: delay,
              child: catWidget,
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  // Animação de preview de raridade
  static Widget buildRarityPreview({
    required AnimationController controller,
    required int highestRarity,
    required int totalCats,
  }) {
    Color previewColor;
    String rarityText;
    IconData rarityIcon;

    switch (highestRarity) {
      case 6:
        previewColor = Colors.red;
        rarityText = 'SECRETO!';
        rarityIcon = Icons.star;
        break;
      case 5:
        previewColor = Colors.orange;
        rarityText = 'LENDÁRIO!';
        rarityIcon = Icons.star;
        break;
      case 4:
        previewColor = Colors.purple;
        rarityText = 'RARO!';
        rarityIcon = Icons.star_half;
        break;
      default:
        previewColor = Colors.blue;
        rarityText = 'COMUM';
        rarityIcon = Icons.star_border;
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Fundo pulsante - CORRIGIDO
              Container(
                width: 200 * controller.value,
                height: 200 * controller.value,
                decoration: BoxDecoration(
                  color: previewColor.withOpacity(0.4 * controller.value), // CORREÇÃO AQUI
                  shape: BoxShape.circle,
                ),
              ),
              
              // Conteúdo principal
              Opacity(
                opacity: controller.value,
                child: Transform.scale(
                  scale: 0.7 + 0.3 * controller.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        rarityIcon,
                        size: 50,
                        color: previewColor,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        rarityText,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: previewColor,
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: previewColor.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$totalCats Gato(s) Obtido(s)',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
