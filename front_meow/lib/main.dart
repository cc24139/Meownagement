import 'package:flutter/material.dart';
import 'package:front_meow/services/serv.dart';
import 'package:front_meow/telas/tela_alterar_perfil.dart';
import 'package:front_meow/telas/tela_alterar_senha.dart';
import 'package:front_meow/telas/tela_amizades.dart';
import 'package:front_meow/telas/tela_cadastro.dart';
import 'package:front_meow/telas/tela_cod_confirmacao.dart';
import 'package:front_meow/telas/tela_criar_meta.dart';
import 'package:front_meow/telas/tela_gacha.dart';
import 'package:front_meow/telas/tela_galeria.dart';
import 'package:front_meow/telas/tela_gato.dart';
import 'package:front_meow/telas/tela_gato_do_user.dart';
import 'package:front_meow/telas/tela_gaveta.dart';
import 'package:front_meow/telas/tela_login.dart';
import 'package:front_meow/telas/tela_inicial.dart';
import 'package:front_meow/telas/tela_perfil.dart';
import 'package:front_meow/telas/tela_transacoes.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  await initLocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meownagement",
      initialRoute: "/amizades",
      routes: {

        "/"               : (context) => const TelaPerfil(), //Mudar para tela inicial
        "alterarPerfil"   : (context) => const TelaAlterarPerfil(),
        "/alterarSenha"   : (context) => const TelaAlterarSenha(),
        "/amizades"       : (context) => const TelaAmizades(),
        "/cadastro"       : (context) => const TelaCadastro(),
        "/confirmacao"    : (context) => const TelaCodConfirmacao(),
        "/criarMeta"      : (context) => const TelaCriarMeta(),
        "/gacha"          : (context) => const TelaGacha(),
        "/galeria"        : (context) => const TelaGaleria(),
        "/gato"           : (context) => const TelaGato(),
        "/gatoDoUser"     : (context) => const TelaGatoDoUser(),
        "/gaveta"         : (context) => const TelaGaveta(),
        "/login"          : (context) => const TelaLogin(),
        "/perfil"         : (context) => const TelaPerfil(),
        "/transacoes"     : (context) => const TelaTransacoes(),



      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arial'),

    );
  }
}

