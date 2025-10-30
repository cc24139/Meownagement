import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/locator.dart';
import 'package:front_meow/models/gato.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/GatoServices.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioPerfilModel.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioViewModel.dart';
import 'package:localstorage/localstorage.dart';
import 'package:front_meow/services/ViewModel/perfilViewModel.dart';

class TelaPerfil extends StatefulWidget {
  final UsuarioPerfilModel user;
  final bool outroUser;

  const TelaPerfil({super.key, required this.user, required this.outroUser});
  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final GatoServices serv = locator<GatoServices>();
  UsuarioPerfilModel? usuarioPerfil;
  List<Gato> dados = [];
  bool _carregando = false;
  CatColors cores = CatColors(
    paleta: int.parse(localStorage.getItem('paleta') ?? '1'),
  );

  Future<void> _carregarGatos() async {
    try {
      UsuarioServices usuarioServices = locator<UsuarioServices>();
      setState(() async {
        if (widget.outroUser) {
          usuarioPerfil = await usuarioServices.UsuarioPorId(
            widget.user!.idUsuario!,
          );
        } else {
          usuarioPerfil = await usuarioServices.PerfilUsuario();
        }
        dados = usuarioPerfil!.gatosDesbloqueados!.reversed.toList();
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

  MaterialColor _getCorPorRaridade(int raridade) {
    if (raridade == 3) {
      return Colors.blue;
    } else if (raridade == 4) {
      return Colors.purple;
    } else if (raridade == 5) {
      return Colors.orange;
    } else if (raridade == 6) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: 10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/images/${usuarioPerfil!.gatoEquipado?.nomeImagem}/${usuarioPerfil!.gatoEquipado?.nomeImagem}Media.jpg',
                                ),
                                radius: 60,
                              ),
                              Text(
                                usuarioPerfil!.nome.toString(),
                                style: TextStyle(
                                  color: cores.complementar,
                                  fontSize: 48,
                                  fontFamily: "Londrina",
                                  decorationColor: cores.complementar,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (widget.outroUser) return;
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRotas.alterarPerfil,
                                  );
                                },
                                icon: Icon(
                                  Icons.edit_square,
                                  color: widget.outroUser
                                      ? Colors.transparent
                                      : cores.complementar,
                                  size: 30,
                                  fill: 0.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                SizedBox(width: 70),
                Text(
                  "Gatos",
                  style: TextStyle(color: cores.complementar, fontSize: 16),
                ),
                Icon(Icons.arrow_forward, color: cores.complementar, size: 16),
                Text(
                  dados.length.toString(),
                  style: TextStyle(
                    color: cores.corTerciaria,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 400,
              child: Divider(color: cores.complementar, thickness: 1),
            ),
            SizedBox(
              width: 360,
              child: Text(
                usuarioPerfil!.biografia.toString() == "null"
                    ? "Sem biografia."
                    : usuarioPerfil!.biografia.toString(),
                style: TextStyle(color: cores.complementar, fontSize: 16),
              ),
            ),

            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Galeria",
                  style: TextStyle(color: cores.complementar, fontSize: 32),
                ),
              ],
            ),

            Wrap(
              spacing: 8, // espaço horizontal entre os cards
              runSpacing: 8, // espaço vertical entre as linhas
              alignment: WrapAlignment.center,
              children: dados.map((gato) {
                return ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: _getCorPorRaridade(gato.raridade),
                      ),
                    ),
                    child: Image.asset(
                      "assets/images/${gato.nomeImagem}/${gato.nomeImagem}Pequena.jpg",
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      backgroundColor: cores.primaria,
      drawer: Menulateralwidget(),
    );
  }
}
