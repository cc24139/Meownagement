import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/locator.dart';
import 'package:front_meow/models/gato.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/GatoServices.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioPerfilModel.dart';
import 'package:localstorage/localstorage.dart';

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
    setState(() {
      _carregando = true;
    });

    try {
      UsuarioServices usuarioServices = locator<UsuarioServices>();

      // Fazer o trabalho assíncrono ANTES do setState
      UsuarioPerfilModel usuarioCarregado;
      if (widget.outroUser) {
        usuarioCarregado = await usuarioServices.UsuarioPorId(
          widget.user.idUsuario!,
        );
      } else {
        usuarioCarregado = await usuarioServices.PerfilUsuario();
      }

      // Agora atualizar o estado de forma síncrona
      setState(() {
        usuarioPerfil = usuarioCarregado;
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
    // Se ainda estiver carregando ou não temos dados, mostrar indicador de progresso
    if (_carregando || usuarioPerfil == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: cores.corSecundaria),
        ),
        backgroundColor: cores.primaria,
        drawer: Menulateralwidget(),
      );
    }

    // A partir daqui, usuarioPerfil não é nulo
    final perfil = usuarioPerfil!;

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
                                  'assets/images/${perfil.gatoEquipado?.nomeImagem}/${perfil.gatoEquipado?.nomeImagem}Media.jpg',
                                ),
                                radius: 60,
                              ),
                              Text(
                                perfil.nome.toString(),
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
                perfil.biografia.toString() == "null"
                    ? "Sem biografia."
                    : perfil.biografia.toString(),
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
