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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, color: cores.complementar, size: 40),
                  MeowcoinWidget(saldo: 20),
                  
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
              
              Container(
                decoration: BoxDecoration(
                  color: cores.complementar,
                  border: Border.all(
                    color: cores.corTerciaria,
                    width: 2.0
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 1),
                    Text("Veja suas metas", style: TextStyle(color: cores.secundaria)),
                    Icon(Icons.arrow_right_alt, color: cores.corSecundaria, size: 30,)
                  ],
                )
              )

            ],
          )
        ),
      ),
      
      drawer: Drawer(),
      backgroundColor: cores.corPrimaria,
    );
  }
}
