import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/gato.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioViewModel.dart';
import 'package:front_meow/services/ViewModel/perfilViewModel.dart';

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
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, color: cores.complementar, size: 25),
            );
          },
        ),
        backgroundColor: cores.corPrimaria,
        centerTitle: true,
      ),
      drawer: Menulateralwidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: onSearchChanged,
              style: TextStyle(color: cores.complementar),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: cores.complementar),
                hintText: "Pesquisar usuários...",
                hintStyle: TextStyle(
                  color: cores.complementar.withOpacity(0.7),
                ),
                filled: true,
                fillColor: cores.corSecundaria.withOpacity(0.15),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cores.complementar, width: 1.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cores.complementar, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<UsuarioViewModel>>(
              future: todosOsUsuarios,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro: ${snapshot.error}",
                      style: TextStyle(color: cores.complementar),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "Nenhum usuário encontrado",
                      style: TextStyle(color: cores.complementar),
                    ),
                  );
                }

                List<UsuarioViewModel> dados = snapshot.data!;
                if (textoPesquisa.isNotEmpty) {
                  dados = dados
                      .where(
                        (u) => u.nome.toLowerCase().contains(
                          textoPesquisa.toLowerCase(),
                        ),
                      )
                      .toList();
                }

                return ListView.separated(
                  itemCount: dados.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final usuario = dados[index];
                    // final perfil = PerfilViewModel(
                    //   idUsuario: usuario.id,
                    //   nome: usuario.nome,
                    //   email: usuario.email,
                    //   pontos: usuario.pontos,
                    //   saldo: usuario.saldo,
                    //   biogradia: usuario.biografia
                    //   gatoEquipado: , //GET GATO EQUIPADO POR ID
                    // );
                    return ListTile(
                      title: Text(
                        usuario.nome,
                        style: TextStyle(color: cores.complementar),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.send, color: cores.complementar),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRotas.perfil,
                            arguments: {'user': usuario.id, 'outroUser': true},
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
