import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text("Usuários")),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: dados.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 20,
                    ),
                    title: Text(dados[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        print("Enviar mensagem para ${dados[index]}");
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
