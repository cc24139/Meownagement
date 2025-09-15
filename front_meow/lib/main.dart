import 'package:flutter/material.dart';
import 'package:front_meow/telas/telaAlterarPerfil.dart';
import 'package:front_meow/telas/telaAlterarSenha.dart';
import 'package:front_meow/telas/telaAmizades.dart';
import 'package:front_meow/telas/telaCadastro.dart';
import 'package:front_meow/telas/telaCriarMeta.dart';
import 'package:front_meow/telas/telaGacha.dart';
import 'package:front_meow/telas/telaGaleria.dart';
import 'package:front_meow/telas/telaGato.dart';
import 'package:front_meow/telas/telaGatoDoUser.dart';
import 'package:front_meow/telas/telaGaveta.dart';
import 'package:front_meow/telas/telaLogin.dart';
import 'package:front_meow/telas/telaInicial.dart';
import 'package:front_meow/telas/telaPerfil.dart';
import 'package:front_meow/telas/telaTransacoes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meownagement",
      initialRoute: "/",
      routes: {
        //Quando existir a tela inicial:
        "/": (context) => const TelaLogin(), //Mudar para tela inicial
        "alterarPerfil" : (context) => const TelaAlterarPerfil(),
        "/alterarSenha" : (context) => const TelaAlterarSenha(),
        "/amizades"     : (context) => const TelaAmizades(),
        "/cadastro"     : (context) => const TelaCadastro(),
        "/criarMeta"    : (context) => const TelaCriarMeta(),
        "/gacha"        : (context) => const TelaGacha(),
        "/galeria"      : (context) => const TelaGaleria(),
        "/gato"         : (context) => const TelaGato(),
        "/gatoDoUser"   : (context) => const TelaGatoDoUser(),
        "/gaveta"       : (context) => const TelaGaveta(),
        "/login"        : (context) => const TelaLogin(),
        "/perfil"       : (context) => const TelaPerfil(),
        "/transacoes"   : (context) => const TelaTransacoes(),


      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arial'),

    );
  }
}

