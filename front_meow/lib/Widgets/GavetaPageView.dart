import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/GraficoConclusaoWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/Cofrinho.dart';
import 'package:front_meow/services/CofrinhoServices.dart';
import 'package:front_meow/services/ViewModel/View/CofrinhoPorcentagemViewModel.dart';

class GavetaPageView extends StatelessWidget {
  final List<CofrinhoPorcentagemViewModel> gaveta;
  final CatColors cor;

  const GavetaPageView({super.key, required this.gaveta, required this.cor});

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
        itemCount: gaveta.length,
        itemBuilder: (context, index) {
          final meta = gaveta[index];
          return _metaCard(meta, context);
        },
      ),
    );
  }

  Widget _metaCard(CofrinhoPorcentagemViewModel gaveta, BuildContext context) {
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
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            gaveta.cofrinho.nome,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 80),
          Text(
            'R\$ ${gaveta.cofrinho.economia.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Londrina',
              color: Color(0x93888888),
            ),
          ),
          Text(
            'R\$ ${gaveta.cofrinho.dinheiroEconomizado.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 36,
              fontFamily: 'Londrina',
              color: Colors.black,
            ),
          ),
          SizedBox(height: 80),
          GraficoConclusaoWidget(
            porcentagem: gaveta.totalGanho,
            catColors: cor,
          ),
          const SizedBox(height: 20),
          if(gaveta.cofrinho.dataTermino.isBefore(DateTime.now())) ...{
                      Text(
              'Ganhe ${gaveta.cofrinho.qtsMoedas} MeowCoins ao concluir!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ElevatedButtonWidget(
              text: "Concluir",
              onPressed: () {
                _ConcluirMeta(context, gaveta.cofrinho.idCofrinho);
              },
              highSize: ButtonSize.muitoPequeno,
              widthSize: ButtonSize.muitoPequeno,
              catColors: cor,
            ),
          } else ...{
            Text(
              "Prazo da gaveta: ${gaveta.cofrinho.dataTermino.day}/${gaveta.cofrinho.dataTermino.month}/${gaveta.cofrinho.dataTermino.year} ",
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

  void _ConcluirMeta(BuildContext context, int id) async {
    print('Concluir gaveta com id: $id');
    try {
      var result = await CofrinhoServices().ConcluirCofrinho(id);
      print('Gaveta concluída com sucesso!');
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Gaveta concluída'),
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
