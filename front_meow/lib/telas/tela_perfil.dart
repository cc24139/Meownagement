import 'package:flutter/material.dart';
import 'package:front_meow/model/usuario.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioViewModel.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UsuarioViewModel;
    return Scaffold(
      body: Text(
        args.nome
      ),
      
    );
  }
}
