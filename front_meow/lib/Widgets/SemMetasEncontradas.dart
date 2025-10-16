import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/rotas.dart';


void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: SemMetasEncontradas(
            cor: CatColors(paleta: 2)
          ),
        ),
      ),
    ),
  );
}

class SemMetasEncontradas extends StatelessWidget {
  final CatColors cor;

  const SemMetasEncontradas({super.key, required this.cor});

  @override
  Widget build(BuildContext context) {
    return _card(context);
  }

 Widget _card(BuildContext context) {
      return Container(
        height: 450,
        width: 300,
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Nenhuma meta encontrada",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontFamily: 'Londrina',
                color: Color(0x93888888),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButtonWidget(text: "Criar", onPressed: (){
              Navigator.pushReplacementNamed(context, AppRotas.criarMeta);
              },highSize: ButtonSize.pequeno, widthSize: ButtonSize.medio, catColors: cor)
          ],  
        ),
      );

  }
}