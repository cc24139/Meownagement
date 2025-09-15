import 'package:flutter/material.dart';
import 'package:front_meow/telas/telaAlterarSenha.dart';
import 'package:front_meow/telas/telaCadastro.dart';
import 'package:front_meow/telas/telaLogin.dart';

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
        "/": (context) => const TelaLogin(),
        "/cadastro": (context) => const TelaCadastro(),
        "/alterarSenha": (context) => const TelaAlterarSenha(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arial'),
      //home: TelaLogin(),
    );
  }
}

