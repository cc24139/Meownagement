import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/GraficoConclusaoWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/Meta.dart';


var meta1 = Metas(idMeta: 1, nome: "Viajar para o Japão", gastoLimite: 5000,
             qtsMoedas: 10,feita: "Não",dataCriacao: DateTime.now(),
             idUsuario: 1,idClassificacao: 1, dataTermino: DateTime(2025,12,31)
            );

var meta2 = Metas(idMeta: 2, nome: "Sair de casa", gastoLimite: 7000,
             qtsMoedas: 10,feita: "Não",dataCriacao: DateTime.now(),
             idUsuario: 1,idClassificacao: 1, dataTermino: DateTime(2025,11,28)
            );

List<Metas> metasExemplo = [meta1,meta2];
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: MetasPageView(
            metas: metasExemplo,
            cor: CatColors(paleta: 2)
          ),
        ),
      ),
    ),
  );
}

class MetasPageView extends StatelessWidget {
  final List<Metas> metas;
  final CatColors cor;

  const MetasPageView({super.key, required this.metas, required this.cor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 475, // Tamanho do PageView
      width: 325, // Largura do PageView
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: PageController(
          viewportFraction: 0.9,
          initialPage: 0,
        ),
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
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: cor.corTerciaria,width: 2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: cor.corTerciaria.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              meta.nome,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 80),
            Text(
              'R\$ ${meta.gastoLimite.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Londrina',
                color: Color(0x93888888)
                ),
            ),
            Text(
              'R\$ ${meta.gastoLimite.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Londrina',
                color: Colors.black
                ),
            ),
            SizedBox(height: 80),
            GraficoConclusaoWidget(
              porcentagem: 25,
              catColors: cor,
            ),
          ],  
        ),
      );

  }
}