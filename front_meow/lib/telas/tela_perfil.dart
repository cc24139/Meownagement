import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/usuario.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioViewModel.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  @override
  Widget build(BuildContext context) {
    CatColors cores = CatColors(paleta: 4);

    //final args = ModalRoute.of(context)!.settings.arguments as UsuarioViewModel;
    var a = UsuarioViewModel(
      id: 1,
      nome: "RonaldoGames",
      email: "jaoao",
      pontos: 67,
      saldo: 212,
    );
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    '../assets/images/doudouCat/doudouCatPequena.jpg',
                  ),
                  radius: 40,
                ),
                Expanded(
                  child: Center(
                    child: Row(
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
                        Text(
                          a.nome,
                          style: TextStyle(
                            fontSize: 45,
                            fontFamily: "Londrina",
                            decorationColor: cores.complementar,
                          ),
                        ),
                        SvgPicture.asset(
                          "../assets/icons/vetor_editar.svg",
                          colorFilter: ColorFilter.mode(Colors.black,BlendMode.clear),
                        )
                      ] 
                    )
                    

                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
      backgroundColor: cores.primaria,
      drawer: Menulateralwidget(),
    );
  }
}
