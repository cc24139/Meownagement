import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/usuario.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioViewModel.dart';
import 'package:front_meow/services/serv.dart';

class TelaAmizades extends StatefulWidget {
  const TelaAmizades({super.key});

  @override
  State<TelaAmizades> createState() => _TelaAmizadesState();
}

class _TelaAmizadesState extends State<TelaAmizades> {
  String textoPesquisa = "";
  late Future<List<UsuarioViewModel>> todosOsUsuarios;
  CatColors cores = CatColors(paleta: 4);

  @override
  void initState() {
    super.initState();
    var httpUsuarios = UsuarioServices();
    todosOsUsuarios = httpUsuarios.ListarUsuarios();
  }
  late List<Usuario> dados;

  void onSearchChanged(String value) {
    setState(() {
      textoPesquisa = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cores.corPrimaria,
      appBar: AppBar(
        title: const Text(
          "Usuários",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: "Londrina",
          ),
        ),
        backgroundColor: cores.corPrimaria,
        centerTitle: true,
      ),
      body: FutureBuilder<List<UsuarioViewModel>>(
        future: todosOsUsuarios,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
              return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Nenhum usuário encontrado"));
          }

          List<UsuarioViewModel> dados = snapshot.data!;
          if (textoPesquisa.isNotEmpty) {
            dados = dados
                .where((u) => u.nome.toLowerCase().contains(textoPesquisa.toLowerCase()))
                .toList();
          }

          return ListView.separated(
            itemCount: dados.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dados[index].nome),
                trailing: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRotas.perfil,
                      arguments: dados[index],
                    );
                  },
                ),
              );
            },
          );
        } 
      ),
      drawer: Menulateralwidget(),
    );
  }
}
