// import 'package:flutter/material.dart';
// import 'package:front_meow/Widgets/MenuLateralWidget.dart';
// import 'package:front_meow/colors/colors.dart';

// class TelaGaveta extends StatefulWidget {
//   const TelaGaveta({super.key});

//   @override
//   State<TelaGaveta> createState() => _TelaGavetaState();
// }

// class _TelaGavetaState extends State<TelaGaveta> {
//   CatColors cores = CatColors(paleta: 4);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Builder(
//                   builder: (context) {
//                     return IconButton(
//                       onPressed: () {
//                         Scaffold.of(context).openDrawer();
//                       },
//                       icon: Icon(Icons.menu, color: cores.complementar, size: 25),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//         drawer: Menulateralwidget(),
//         backgroundColor: cores.corPrimaria,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/Widgets/TitleTelaWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/Widgets/VerticalSelectWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/rotas.dart';
import 'package:intl/intl.dart';


class TelaGaveta extends StatefulWidget {
  const TelaGaveta({super.key});

  @override
  State<TelaGaveta> createState() => _TelaGavetaState();
}

enum OpcoesTransacao { despesa, receita }

final List<String> listaClassificacao = <String>["a", "b", "c", "d"];
final List<String> listaRecorrencia = <String>["aaaa", "Bbbb", "cccc", "dddd"];

void _cancelar(BuildContext context) {
  Navigator.pushReplacementNamed(context, AppRotas.inicial);
}

void _salvar(BuildContext context) {
  //TODO salvar na api os dados
  Navigator.pushReplacementNamed(context, AppRotas.inicial);
}

class _TelaGavetaState extends State<TelaGaveta> {
  OpcoesTransacao? _opcoesTransacao = OpcoesTransacao.despesa;

  String dropdownValue = listaClassificacao.first;
  CatColors cores = CatColors(paleta: 4);
  @override
  void dispose() {
    super.dispose();
  }

  void _trocar() {
    //Troar icone e texto
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: cores.complementar,
                            size: 25,
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: TitleTelaWidget(
                        title: "Guarde na Gaveta",
                        subtitle: "",
                        catColors: cores,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25),
                
                Row(
                  children: [
                    Verticalselectwidget<OpcoesTransacao>(
                      label: 'Semanal',
                      value: OpcoesTransacao.despesa,
                      groupValue: _opcoesTransacao,
                      cores: cores,
                      onChanged: (value) {
                        setState(() {
                          _opcoesTransacao = value;
                        });
                      },
                    ),

                    Verticalselectwidget<OpcoesTransacao>(
                      label: 'Mensal',
                      value: OpcoesTransacao.despesa,
                      groupValue: _opcoesTransacao,
                      cores: cores,
                      onChanged: (value) {
                        setState(() {
                          _opcoesTransacao = value;
                        });
                      },
                    ),

                    Verticalselectwidget<OpcoesTransacao>(
                      label: 'Anual',
                      value: OpcoesTransacao.despesa,
                      groupValue: _opcoesTransacao,
                      cores: cores,
                      onChanged: (value) {
                        setState(() {
                          _opcoesTransacao = value;
                        });
                      },
                    ),
                  ],
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(160, 60),
                        backgroundColor: cores.corTerciaria,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      onPressed: () {
                        _cancelar(context);
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                          color: cores.complementar,
                          fontSize: 24,
                        ),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(260, 60),
                        backgroundColor: cores.corSecundaria,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      onPressed: () {
                        _salvar(context);
                      },
                      child: Text(
                        "Efetuar",
                        style: TextStyle(
                          color: cores.complementar,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
        backgroundColor: cores.primaria,
        drawer: Menulateralwidget(),
    );
  }
}
