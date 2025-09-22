import 'package:flutter/material.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/rotas.dart';

class TelaAmizades extends StatefulWidget {
  const TelaAmizades({super.key});

  @override
  State<TelaAmizades> createState() => _TelaAmizadesState();
}

class _TelaAmizadesState extends State<TelaAmizades> {
  String textoPesquisa = "";
  final List<String> todosUsuarios = <String>[
    'Ronaldo',
    'Roberto',
    'Sampaio',
    'Rilex',
    'Ronaldo 2',
  ];
  CatColors cores = CatColors(paleta: "");

  List<String> dados = [];

  @override
  void initState() {
    super.initState();
    dados = todosUsuarios;
  }

  void onSearchChanged(String value) {
    setState(() {
      textoPesquisa = value;
      dados = todosUsuarios
          .where((nome) => nome.toLowerCase().contains(value.toLowerCase()))
          .toList();
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 300,
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: "Digite o username",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Color(0XFFD9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            // Expanded(
            //   child: ListView.separated(
            //     itemCount: dados.length,
            //     separatorBuilder: (context, index) =>
            //         const Divider(height: 1, thickness: 1, color: Colors.grey),
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         tileColor: Colors.white,
            //         leading: const CircleAvatar(
            //           backgroundColor: Colors.grey,
            //           radius: 20,
            //         ),
            //         title: Text(dados[index]),
            //         trailing: IconButton(
            //           icon: const Icon(Icons.send),
            //           onPressed: () {
            //             Navigator.pushReplacementNamed(
            //               context,
            //               AppRotas.perfil,
            //               arguments: {"username": dados[index]},
            //             );
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // Expanded(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white, // background of the whole group
            //       borderRadius: BorderRadius.circular(20), // rounded corners of the group
            //       border: Border.all(
            //         color: Colors.grey, // border color of the group
            //         width: 1,
            //       ),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black12,
            //           blurRadius: 4,
            //           offset: Offset(0, 2),
            //         ),
            //       ],
            //     ),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20), // clip ListView inside the rounded container
            //       child: ListView.separated(
            //         padding: const EdgeInsets.symmetric(vertical: 10),
            //         itemCount: dados.length,
            //         separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
            //         itemBuilder: (context, index) {
            //           return ListTile(
            //             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //             leading: const CircleAvatar(
            //               backgroundColor: Colors.grey,
            //               radius: 20,
            //             ),
            //             title: Text(dados[index]),
            //             trailing: IconButton(
            //               icon: const Icon(Icons.send),
            //               onPressed: () {
            //                 Navigator.pushReplacementNamed(
            //                   context,
            //                   AppRotas.perfil,
            //                   arguments: {"username": dados[index]},
            //                 );
            //               },
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // padding around the group
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ListView.separated(
                      shrinkWrap: true, 
                      physics: const NeverScrollableScrollPhysics(), 
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: dados.length,
                      separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 20,
                          ),
                          title: Text(dados[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRotas.perfil,
                                arguments: {"username": dados[index]},
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
