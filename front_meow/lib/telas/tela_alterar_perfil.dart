import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class TelaAlterarPerfil extends StatefulWidget {
  const TelaAlterarPerfil({super.key});

  @override
  State<TelaAlterarPerfil> createState() => _TelaAlterarPerfilState();
}


void _salvar(){

}

void _cancelar(){

}

class _TelaAlterarPerfilState extends State<TelaAlterarPerfil> {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtBio = TextEditingController();

  @override
  void dispose() {
    txtNome.dispose();
    txtBio.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Perfil")
  //     ),

  //     body: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 TextField(
  //                   controller: txtNome,
  //                   decoration: const InputDecoration(
  //                     labelText: "Nome do perfil",
  //                     border: OutlineInputBorder(),
  //                   ),
  //                 ),
  //                 SizedBox(height: 10),
  //                 TextField(
  //                   controller: txtBio,
  //                   decoration: const InputDecoration(
  //                     labelText: "Nome do perfil",
  //                     border: OutlineInputBorder(),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 _cancelar();
  //               },
  //               child: Text("Cancelar"),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 _salvar();
  //               },
  //               child: Text("Salvar"),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Perfil")),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: txtNome,
            decoration: const InputDecoration(
              labelText: "Nome do perfil",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: txtBio,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            maxLength: 250,
            decoration: const InputDecoration(
              labelText: "Bio",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _cancelar,
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text("Salvar"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}

