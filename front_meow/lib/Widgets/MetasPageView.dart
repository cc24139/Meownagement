import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/GraficoConclusaoWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/cofrinho.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/ViewModel/View/MetaPorcentagemVIewModel.dart';
import 'package:front_meow/services/metaServices.dart';

// var meta1 = Metas(idMeta: 1, nome: "Viajar para o Japão", gastoLimite: 5000,
//              qtsMoedas: 10,feita: "Não",dataCriacao: DateTime.now(),
//              idUsuario: 1,idClassificacao: 1, dataTermino: DateTime(2025,12,31)
//             );

// var meta2 = Metas(idMeta: 2, nome: "Sair de casa", gastoLimite: 7000,
//              qtsMoedas: 10,feita: "Não",dataCriacao: DateTime.now(),
//              idUsuario: 1,idClassificacao: 1, dataTermino: DateTime(2025,11,28)
//             );

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: MetasPageView(metas: [], cor: CatColors(paleta: 2)),
        ),
      ),
    ),
  );
}

class MetasPageView extends StatelessWidget {
  final List<MetasPorcentagemViewModel> metas;
  final CatColors cor;

  const MetasPageView({super.key, required this.metas, required this.cor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600, // Tamanho do PageView
      width: 450, // Largura do PageView
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: PageController(viewportFraction: 0.9, initialPage: 0),
        physics: const PageScrollPhysics(), // mantém o scroll padrão de páginas
        pageSnapping: true,
        itemCount: metas.length,
        itemBuilder: (context, index) {
          final meta = metas[index];
          return _metaCard(meta, context);
        },
      ),
    );
  }

  Widget _metaCard(
    MetasPorcentagemViewModel metaPorcentagem,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: cor.corTerciaria, width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: cor.corTerciaria.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            metaPorcentagem.meta.nome,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 80),
          Text(
            'R\$ ${metaPorcentagem.meta.gastoLimite.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Londrina',
              color: Color(0x93888888),
            ),
          ),
          Text(
            'R\$ ${metaPorcentagem.totalGasto.toStringAsFixed(2)}',
            style:  TextStyle(
              fontSize: 36,
              fontFamily: 'Londrina',
              color: _getColor(metaPorcentagem.totalGasto, metaPorcentagem.meta.gastoLimite),
            ),
          ),
          const SizedBox(height: 80),
          GraficoConclusaoWidget(
            porcentagem: (metaPorcentagem.totalGasto).abs() / metaPorcentagem.meta.gastoLimite * 100 > 100 ? 100 : (metaPorcentagem.totalGasto).abs() / metaPorcentagem.meta.gastoLimite * 100,
            catColors: cor,
          ),
          const SizedBox(height: 20),
          if (metaPorcentagem.meta.dataTermino.isBefore(DateTime.now())) ...{
            Text(
              'Ganhe ${metaPorcentagem.meta.qtsMoedas} MeowCoins ao concluir!',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ElevatedButtonWidget(
              text: "Concluir",
              onPressed: () {
                _ConcluirMeta(context, metaPorcentagem.meta.idMeta);
              },
              highSize: ButtonSize.muitoPequeno,
              widthSize: ButtonSize.muitoPequeno,
              catColors: cor,
            ),
          } else ...{
            Text(
              "Prazo da meta: ${metaPorcentagem.meta.dataTermino.day}/${metaPorcentagem.meta.dataTermino.month}/${metaPorcentagem.meta.dataTermino.year}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          },
        ],
      ),
    );
  }

  Color? _getColor(valor,limite) {
    var porcentagem = (valor).abs() / limite * 100;
    if (porcentagem >= 100) {
      return Colors.red;
    } else if (porcentagem < 100 && porcentagem >= 50) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
  void _ConcluirMeta(BuildContext context, int id) async {
    try {
      var result = await Metaservices().concluirMetas(id);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Meta concluída'),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.pushNamed(context, "/");
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Erro'),
          content: Text('${e.toString()}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
