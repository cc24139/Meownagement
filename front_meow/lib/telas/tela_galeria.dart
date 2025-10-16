import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/gato.dart';

class TelaGaleria extends StatefulWidget {
  const TelaGaleria({super.key});

  @override
  State<TelaGaleria> createState() => _TelaGaleriaState();
}

class CardGato extends StatelessWidget {
  final String nome;
  final String imagem;
  const CardGato({Key? key, required this.nome, required this.imagem})
    : super(key: key);

  @override
  Widget build(BuildContext contect) {
    CatColors cores = CatColors(paleta: 4);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Builder(
            //   builder: (context) {
            //     return IconButton(
            //       onPressed: () {
            //         Scaffold.of(context).openDrawer();
            //       },
            //       icon: Icon(Icons.menu, color: cores.primaria, size: 40),
            //     );
            //   },
            // ),
            Image.asset(
              '../assets/images/$imagem/' + imagem + 'pequena.jpg',
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 10),
            Text(nome),
          ],
        ),
      ),
    );
  }
}

class _TelaGaleriaState extends State<TelaGaleria> {
  late Future<List<Gato>> as;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Galeria")),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: [
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
              CardGato(nome: "miauauau", imagem: "doudouCat"),
            ],
          ),
        ),  
      ),
      drawer: Menulateralwidget(),
    );
  }
}
