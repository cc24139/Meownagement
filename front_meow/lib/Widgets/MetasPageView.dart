import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/GraficoConclusaoWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/Meta.dart';
import 'package:front_meow/services/ViewModel/View/MetaPorcentagemVIewModel.dart';
import 'package:front_meow/services/metaServices.dart';
import 'package:front_meow/locator.dart';

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
          child: MetasPageView(
            metas: [],
            cor: CatColors(paleta: 2),
            metaServices: Metaservices(),
          ),
        ),
      ),
    ),
  );
}

class MetasPageView extends StatelessWidget {
  final Metaservices metaServices;
  final List<Metas> metas;
  final CatColors cor;

  const MetasPageView({
    super.key,
    required this.metas,
    required this.cor,
    required this.metaServices,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 475, // Tamanho do PageView
      width: 325, // Largura do PageView
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: PageController(viewportFraction: 0.9, initialPage: 0),
        physics: const PageScrollPhysics(), // mantém o scroll padrão de páginas
        pageSnapping: true,
        itemCount: metas.length,
        itemBuilder: (context, index) {
          final meta = metas[index];
          return _metaCard(meta);
        },
      ),
    );
  }

  Widget _metaCard(Metas meta) {
    return FutureBuilder<List<MetasPorcentagemViewModel>>(
      future: metaServices.listarMetasComPorcentagem(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: cor.corTerciaria, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: cor.corTerciaria, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(child: Text('Erro ao carregar meta')),
          );
        } else {
          final listaMetasPorcentagem = snapshot.data ?? [];
          final metaPorcentagem = listaMetasPorcentagem.firstWhere(
            (m) => m.meta.idMeta == meta.idMeta,
            orElse: () => MetasPorcentagemViewModel(
              meta: meta,
              transacoes: [],
              totalGasto: 0.0,
            ),
          );

          final porcentagem = metaPorcentagem.meta.gastoLimite > 0
              ? (metaPorcentagem.totalGasto /
                    metaPorcentagem.meta.gastoLimite *
                    100)
              : 0.0;

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
                  style: const TextStyle(
                    fontSize: 36,
                    fontFamily: 'Londrina',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 80),
                GraficoConclusaoWidget(
                  porcentagem: porcentagem.toInt(),
                  catColors: cor,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
