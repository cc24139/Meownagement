// lib/widgets/cat_widgets.dart
import 'package:flutter/material.dart';
import '../models/gato.dart';
import '../animations/gachaAnimations.dart';

class GatoRollWidget {
  // Widget de imagem de gato único
  static Widget buildCatImage({
    required Gato cat,
    double size = 200,
    bool showRarityBadge = true,
  }) {

    Color cor = Colors.blue;

    if (cat.raridade == 3) {
      cor = Colors.blue;
    } else if (cat.raridade == 4) {
      cor = Colors.purple;
    } else if (cat.raridade == 5) {
      cor = Colors.orange;
    }
    else if (cat.raridade == 6) {
      cor = Colors.red;
    }

    String imagePath = 'assets/images/${cat.nomeImagem}/${cat.nomeImagem}Pequena.png';

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: cor,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: cor.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
            if (showRarityBadge)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: cor.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.white),
                      const SizedBox(width: 2),
                      Text(
                        '${cat.raridade}★',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget de imagem de gato múltiplo (menor)
  static Widget buildMultipleCatImage({
    required Gato cat,
    double size = 70,
  }) {

    Color cor = Colors.blue;

    if (cat.raridade == 3) {
      cor = Colors.blue;
    } else if (cat.raridade == 4) {
      cor = Colors.purple;
    } else if (cat.raridade == 5) {
      cor = Colors.orange;
    }
    else if (cat.raridade == 6) {
      cor = Colors.red;
    }

    String imagePath = 'assets/images/${cat.nomeImagem}/${cat.nomeImagem}Pequena.png';

    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: cor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: cor.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            // Badge de raridade pequena
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: cor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${cat.raridade}★',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget completo para gato único com informações
  static Widget buildSingleCatWithInfo({
    required Gato cat,
    required AnimationController controller,
  }) {

    Color cor = Colors.blue;

    if (cat.raridade == 3) {
      cor = Colors.blue;
    } else if (cat.raridade == 4) {
      cor = Colors.purple;
    } else if (cat.raridade == 5) {
      cor = Colors.orange;
    }
    else if (cat.raridade == 6) {
      cor = Colors.red;
    }
    
    return Column(
      children: [
        GachaAnimations.buildJumpingAnimation(
          controller: controller,
          child: buildCatImage(cat: cat, size: 200),
        ),
        const SizedBox(height: 16),
        Text(
          cat.nome,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: cor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${cat.raridade} Estrelas',
          style: TextStyle(
            fontSize: 16,
            color: cor.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  // Widget para lista de gatos com animação sequencial
  static Widget buildMultipleCatsWithAnimation({
    required List<Gato> cats,
    required AnimationController controller,
    int catsPerRow = 5,
  }) {
    // Converte a lista de Cats em lista de Widgets
    List<Widget> catWidgets = cats.map((cat) {
      return buildMultipleCatImage(cat: cat);
    }).toList();

    return GachaAnimations.buildMultipleCatsLayout(
      catWidgets: catWidgets,
      controller: controller,
      catsPerRow: catsPerRow,
    );
  }
}
