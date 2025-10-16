import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/Tools/qualInfo.dart';
import 'package:front_meow/colors/colors.dart';

class QualInfoWidget extends StatefulWidget {
  final CatColors cor;
  // 1. Adicionando o callback opcional
  final ValueChanged<QualInfo>? onInfoChanged;

  const QualInfoWidget({
    super.key,
    required this.cor,
    this.onInfoChanged, // Adicionado ao construtor
  });

  @override
  State<QualInfoWidget> createState() => _QualInfoWidgetState();
}

class _QualInfoWidgetState extends State<QualInfoWidget> {
  QualInfo _qualInfo = QualInfo.transacoes;

  // Função para avançar para o próximo item da lista
  void _proximoItem() {
    setState(() {
      final proximoIndex = (_qualInfo.index + 1) % QualInfo.values.length;
      _qualInfo = QualInfo.values[proximoIndex];
      // 2. Chama o callback com o novo valor, se ele foi fornecido
      widget.onInfoChanged?.call(_qualInfo);
    });
  }

  // Função para voltar ao item anterior da lista
  void _itemAnterior() {
    setState(() {
      final indexAnterior =
          (_qualInfo.index - 1 + QualInfo.values.length) %
              QualInfo.values.length;
      _qualInfo = QualInfo.values[indexAnterior];
      // 2. Chama o callback com o novo valor, se ele foi fornecido
      widget.onInfoChanged?.call(_qualInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_qualInfo) {
      case QualInfo.transacoes:
        return _cont("Histórico de Transações");
      case QualInfo.transacoesRecorrentes:
        return _cont("Transações Recorrentes");
      case QualInfo.metas:
        return _cont("Veja suas Metas");
      case QualInfo.gaveta:
        return _cont("Veja sua Gaveta");
    }
  }

  Widget _cont(String texto) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          _proximoItem();
        } else if (details.primaryVelocity! > 0) {
          _itemAnterior();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: widget.cor.complementar,
          border: Border.all(color: widget.cor.corTerciaria, width: 2.0),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.arrow_left,
              color: widget.cor.corSecundaria.withOpacity(0.7),
              size: 30,
            ),
            Expanded(
              child: Text(
                texto,
                textAlign: TextAlign.center,
                style: TextStyle(color: widget.cor.secundaria, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_right,
              color: widget.cor.corSecundaria.withOpacity(0.7),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}

