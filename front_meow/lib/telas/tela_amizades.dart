import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/rotas.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioPerfilModel.dart';
import 'package:front_meow/services/ViewModel/View/UsuarioViewModel.dart';
import 'package:localstorage/localstorage.dart';

class TelaAmizades extends StatefulWidget {
  const TelaAmizades({super.key});

  @override
  State<TelaAmizades> createState() => _TelaAmizadesState();
}

class _TelaAmizadesState extends State<TelaAmizades> {
  String textoPesquisa = "";
  late Future<List<UsuarioViewModel>> todosOsUsuarios;
  CatColors cores = CatColors(paleta: int.parse( localStorage.getItem('paleta') ?? '1'));

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
      backgroundColor: cores.primaria,
      appBar: AppBar(
        toolbarHeight: 120,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: cores.corPrimaria,
        centerTitle: true,
        title: Text(
          "Usuários",
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
            fontFamily: "Londrina",
            color: cores.complementar,
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
      ),
      drawer: Menulateralwidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
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
                  borderRadius: BorderRadius.circular(32),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cores.complementar, width: 2),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.fromLTRB(40, 40, 40, 64),
              decoration: BoxDecoration(
                color: cores.complementar.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: cores.secundaria,
                  width: 1.2,
                ),
              ),
              child: FutureBuilder<List<UsuarioViewModel>>(
                future: todosOsUsuarios,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Erro: ${snapshot.error}",
                        style: TextStyle(color: cores.secundaria),
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
                      separatorBuilder: (context, __) {
                        final width = MediaQuery.of(context).size.width * 0.7;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: width,
                              height: 1,
                              color: cores.secundaria,
                            ),
                          ),
                        );
                      },
                    itemBuilder: (context, index) {
                      final usuario = dados[index];
                      return ListTile(
                        title: Text(
                          usuario.nome,
                          style: TextStyle(color: cores.complementar),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.send, color: cores.complementar),
                          onPressed: () {
                            var perfil = new UsuarioPerfilModel(
                              idUsuario: usuario.id,
                              nome: usuario.nome,
                              pontos: usuario.pontos,
                              biografia: usuario.biografia,
                              gatoEquipado: null, //GET GATO EQUIPADO POR ID
                            );
                            Navigator.pushNamed(
                              context,
                              AppRotas.perfil,
                              arguments: {'user': perfil, 'outroUser': true},
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
