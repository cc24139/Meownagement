import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_meow/Widgets/MeowCoinWidget.dart';
import 'package:front_meow/colors/colors.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});
  

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  CatColors cores = CatColors(paleta: 4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MeowcoinWidget(saldo: 20),
                  SizedBox(width: 134),
                  Icon(Icons.calendar_today, color: cores.complementar, size: 40)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "../../assets/icons/vetor_olho_fechado.svg",
                        width: 30,
                        height: 30,
                        color: cores.complementar,
                      ),
                      SizedBox(width: 30),
                      Text("Saldo", style: TextStyle(color: cores.complementar)),
                      SizedBox(width: 30,)
                    ],
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children : [Text("...", style: TextStyle(color: Colors.amber),)]),
              
              SizedBox(
                child: Row(
                  children: [
                    Text("Veja suas metas", style: TextStyle(color: cores.complementar),),
                    Icon(Icons.arrow_right, color: cores.complementar,)
                  ],
                )
              )

            ],
          )
        ),
      ),
      
      
      backgroundColor: cores.corPrimaria,
    );
  }
}
