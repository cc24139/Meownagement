import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/Widgets/MeowCoinWidget.dart';
import 'package:front_meow/Widgets/TelaInicialInfosWidget.dart';
import 'package:front_meow/Widgets/Tools/qualInfo.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:front_meow/services/LoginDiarioServices.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  QualInfo infoAtual = QualInfo.metas;
  CatColors cores = CatColors(paleta: 4);
  int meowCoins = 0;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    UsuarioServices().PerfilUsuario().then((usuario) {
      setState(() {
        meowCoins = usuario.pontos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        icon: Icon(Icons.menu, color: cores.complementar, size: 25),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(mensagem)),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())),
                        );
                      });

                    }, 
                    icon: Icon(Icons.calendar_today),
                    color: cores.complementar,
                    iconSize: 40,
                  )
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
                      Text(
                        "Saldo",
                        style: TextStyle(color: cores.complementar),
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: cores.complementar,
                  border: Border.all(color: cores.corTerciaria, width: 2.0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 1),
                    Text(
                      "Veja suas metas",
                      style: TextStyle(color: cores.secundaria),
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      color: cores.corSecundaria,
                      size: 30,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Telainicialinfoswidget(qualInfo: infoAtual, cor: cores)
            ],
          ),
        ),
      ),

      drawer: Menulateralwidget(),
      backgroundColor: cores.corPrimaria,
    );
  }
}
