import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/locator.dart';
import 'package:front_meow/models/gato.dart';
import 'package:front_meow/services/GatoServices.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioViewModel.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  //final UsuarioServices serv = locator<UsuarioServices>();

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final GatoServices serv = locator<GatoServices>();
  List<Gato> dados = [];
  bool _carregando = false;
  CatColors cores = CatColors(paleta: 4);

  Future<void> _carregarGatos() async {
    try {
      List<Gato> gatosDaApi = await serv.ListarDesbloqueados();

      setState(() {
        dados = gatosDaApi;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _carregando = false;
      });
      print("Ocorreu um erro: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarGatos();
  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as UsuarioViewModel;
    var a = UsuarioViewModel(
      id: 1,
      nome: "RonaldoGames",
      email: "jaoao",
      biografia: "cviacapocanpasnc pac scn panc psnadpsn an pas ndapd vodan",
      pontos: 67,
      saldo: 212,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  size: 30,
                                ),
                              );
                            },
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              '../assets/images/doudouCat/doudouCatPequena.jpg',
                            ),
                            radius: 30,
                          ),
                          Text(
                            a.nome,
                            style: TextStyle(
                              color: cores.complementar,
                              fontSize: 45,
                              fontFamily: "Londrina",
                              decorationColor: cores.complementar,
                            ),
                          ),
                          Icon(
                            Icons.edit_square,
                            color: cores.complementar,
                            size: 30,
                            fill: 0.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Text(
                  "Gatos",
                  style: TextStyle(color: cores.complementar, fontSize: 16),
                ),
                Icon(Icons.arrow_forward, color: cores.complementar, size: 16),
                Text(dados.length.toString(), style: TextStyle(color: cores.secundaria, fontSize: 20, fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(
                  width: 400,
                  child: Divider(color: cores.complementar, thickness: 1),
            ),
            SizedBox(
              width: 360,
              child: Text(a.biografia.toString(), style: TextStyle(color: cores.complementar, fontSize: 16)),
            )
          ],
        ),
      ),
      backgroundColor: cores.primaria,
      drawer: Menulateralwidget(),
    );
  }
}
