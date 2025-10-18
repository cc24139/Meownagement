import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/gato.dart';
import 'package:front_meow/services/GatoServices.dart';
import 'package:localstorage/localstorage.dart';

void main() {
  runApp(const MaterialApp(home: TelaGaleria()));
}

class TelaGaleria extends StatefulWidget {
  const TelaGaleria({super.key});

  @override
  State<TelaGaleria> createState() => _TelaGaleriaState();
}

class CardGato extends StatelessWidget {
  final int id;
  final String nome;
  final String imagem;
  final bool equipado;
  final VoidCallback? onEquipar;
  final bool bloqueado;

  const CardGato({
    super.key,
    required this.id,
    required this.nome,
    required this.imagem,
    this.equipado = false,
    this.onEquipar,
    required this.bloqueado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              bloqueado
                  ? 'assets/images/$imagem/${imagem}pequenaPB.jpg'
                  : 'assets/images/$imagem/${imagem}pequena.jpg',
            ),
            const SizedBox(height: 10),
            Text(nome),
            if(!bloqueado) ElevatedButtonWidget(
              text: equipado ? "Equipado" : "Equipar",
              onPressed: () async {
                if (equipado) return;

                localStorage.setItem("gatoEquipado", id.toString());

                // Chamar o callback para recarregar a tela
                if (onEquipar != null) {
                  onEquipar!();
                }
              },
              highSize: ButtonSize.pequeno,
              widthSize: ButtonSize.pequeno,
              catColors: equipado ? CatColors(paleta: 2) : CatColors(paleta: 4),
            ),
          ],
        ),
      ),
    );
  }
}

class _TelaGaleriaState extends State<TelaGaleria> {
  late Future<List<Gato>> _futureGatos;
  late Future<List<Gato>> _futureGatosBloqueados;
  int idGatoEquipado = 0;
  CatColors catColors = CatColors(paleta: 1);

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    // Carrega o gato equipado
    GatoServices gatoServices = GatoServices();
    Gato gato = await gatoServices.GatoEquipado();
    catColors = CatColors(paleta: gato.codPaleta);

    setState(() {
      idGatoEquipado = gato.idGato;
      // Inicia o Future para carregar a lista de gatos
      _futureGatos = gatoServices.ListarDesbloqueados();
      _futureGatosBloqueados = gatoServices.ListarBloqueados();
    });
  }

  void _equiparGato({required int idGato}) {
    localStorage.setItem("gatoEquipado", idGato.toString());
    setState(() {
      idGatoEquipado = idGato;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _futureGatos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('Nenhum gato desbloqueado encontrado.'),
                  );
                } else {
                  List<Gato> gatosDesbloqueados = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8, // espaço horizontal entre os cards
                      runSpacing: 8, // espaço vertical entre as linhas
                      alignment: WrapAlignment.center,
                      children: gatosDesbloqueados.map((gato) {
                        return CardGato(
                          id: gato.idGato,
                          nome: gato.nome,
                          imagem: gato.nomeImagem,
                          equipado: gato.idGato == idGatoEquipado,
                          onEquipar: () => _equiparGato(idGato: gato.idGato),
                          bloqueado: false,
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
            FutureBuilder(
              future: _futureGatosBloqueados,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('Nenhum gato bloqueado encontrado.'),
                  );
                } else {
                  List<Gato> gatosBloqueados = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8, // espaço horizontal entre os cards
                      runSpacing: 8, // espaço vertical entre as linhas
                      alignment: WrapAlignment.center,
                      children: gatosBloqueados.map((gato) {
                        return CardGato(
                          id: gato.idGato,
                          nome: gato.raridade == 6 ? "???" : gato.nome,
                          imagem: gato.raridade == 6
                              ? "Bloqueado"
                              : gato.nomeImagem,
                          bloqueado: true,
                          equipado: false,
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      drawer: Menulateralwidget(),
    );
  }
}
