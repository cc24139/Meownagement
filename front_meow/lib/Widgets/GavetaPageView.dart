import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/GraficoConclusaoWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/Cofrinho.dart';

var gaveta1 = Cofrinho(idCofrinho: 1, nome: "Viagem", economia: 5000.00,
             dinheiroEconomizado: 1500.00, dataCriacao: DateTime.now(),
             idUsuario: 1,idClassificacao: 1, feita: "Não", dataTermino: DateTime(2025,12,31), qtsMoedas: 10
            );
var gaveta2 = Cofrinho(idCofrinho: 2, nome: "Casa nova", economia: 7000.00,
             dinheiroEconomizado: 3000.00, dataCriacao: DateTime.now(),
             idUsuario: 1,idClassificacao: 1, feita: "Não", dataTermino: DateTime(2025,11,28), qtsMoedas: 10
            );

List<Cofrinho> gavetaExemplo = [gaveta1,gaveta2];
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: GavetaPageView(
            gaveta: gavetaExemplo,
            cor: CatColors(paleta: 2)
          ),
        ),
      ),
    ),
  );
}

class GavetaPageView extends StatelessWidget {
  final List<Cofrinho> gaveta;
  final CatColors cor;

  const GavetaPageView({super.key, required this.gaveta, required this.cor});

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
        itemCount: gaveta.length,
        itemBuilder: (context, index) {
          final meta = gaveta[index];
          return _metaCard(meta);
        },
      ),
    );
  }

 Widget _metaCard(Cofrinho gaveta) {

      print(gaveta.nome);
      print(gaveta.economia);
      print(gaveta.dinheiroEconomizado);
      print(gaveta.qtsMoedas);


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
              offset: Offset(0, 3), 
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              gaveta.nome,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 80),
            Text(
              'R\$ ${gaveta.economia.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Londrina',
                color: Color(0x93888888)
                ),
            ),
            Text(
              'R\$ ${gaveta.dinheiroEconomizado.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Londrina',
                color: Colors.black
                ),
            ),
            SizedBox(height: 80),
            GraficoConclusaoWidget(
              porcentagem: int.parse((gaveta.dinheiroEconomizado / gaveta.economia * 100).toStringAsFixed(0)),
              catColors: cor,
            ),
          ],  
        ),
      );

  }
}