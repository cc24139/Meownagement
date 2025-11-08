import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/BolasBaixoTelaInicial.dart';
import 'package:front_meow/Widgets/BolasCimaTelaInicial.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/Widgets/MeowCoinWidget.dart';
import 'package:front_meow/Widgets/SaldoWidget.dart';
import 'package:front_meow/Widgets/TelaInicialInfosWidget.dart';
import 'package:front_meow/Widgets/Tools/qualInfo.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/services/TransacaoServices.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:front_meow/services/LoginDiarioServices.dart';
import 'package:localstorage/localstorage.dart';
import 'package:front_meow/Widgets/QualInfoWidget.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  QualInfo infoAtual = QualInfo.metas;
  CatColors cores = CatColors(
    paleta: int.parse(localStorage.getItem('paleta') ?? '1'),
  );
  int meowCoins = 0;

  @override
  void initState() {
    super.initState();
    _carregarDados();
    _atualizarTransacoes();
  }

  void _atualizarTransacoes() async {
    var transacao = TransacaoServices();
    await transacao.AtualizarTransaceos()
        .then((mensagem) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: cores.corPrimaria,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Column(
                  children: [
                    Icon(Icons.update, color: cores.complementar),
                    SizedBox(width: 8),
                    Text(
                      mensagem,
                      style: TextStyle(
                        color: cores.complementar,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        })
        .catchError((error) {
          // opcional: tratar erro
        });
  }

  void _carregarDados() async {
    UsuarioServices()
        .PerfilUsuario()
        .then((usuario) {
          setState(() {
            meowCoins = usuario.pontos!;
          });
        })
        .catchError((error) {
          // nao esta logado -> manda de volta pro login
          // pop-up avisando que precisa logar
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: cores.corPrimaria,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.redAccent),
                    SizedBox(width: 8),
                    const Text(
                      "Erro",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                content: const Text(
                  "Você precisa estar logado para acessar essa tela.",
                  style: TextStyle(color: Colors.redAccent),
                ),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text("Ir ao Login"),
                  ),
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
              clipper: BolasCimaTelaInicial(),
              child: Container(
                height: 275,
                color: cores.corSecundaria.withOpacity(0.9),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: BolasBaixoTelaInicial(),
              child: Container(
                height: 275,
                color: cores.corSecundaria.withOpacity(0.9),
              ),
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      MeowcoinWidget(saldo: meowCoins),

                      IconButton(
                        onPressed: () {
                          // logico do login diario

                          Logindiarioservices()
                              .AtualizarLoginDiario()
                              .then((mensagem) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: cores.corPrimaria,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      title: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: cores.complementar,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "Login Diário",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Text(
                                        mensagem,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: cores.complementar,
                                            foregroundColor: cores.corPrimaria,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text("Fechar"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              })
                              .catchError((error) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: cores.corPrimaria,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      title: Row(
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.redAccent,
                                          ),
                                          SizedBox(width: 8),
                                          const Text(
                                            "Erro",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Text(
                                        error.toString(),
                                        style: const TextStyle(
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text("Fechar"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });
                        },
                        icon: Icon(Icons.calendar_today),
                        color: cores.complementar,
                        iconSize: 40,
                      ),
                    ],
                  ),  

                  SaldoWidget(cores: cores),
                  SizedBox(height: 10),
                  QualInfoWidget(
                    cor: cores,
                    onInfoChanged: (QualInfo novaInfo) {
                      setState(() {
                        infoAtual = novaInfo;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Telainicialinfoswidget(qualInfo: infoAtual, cor: cores),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Menulateralwidget(),
      backgroundColor: cores.corPrimaria,
    );
  }
}
