import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/models/gato.dart';
import 'package:front_meow/telas/tela_gato.dart';
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
  final int raridade;
  final bool equipado;
  final VoidCallback? onEquipar;
  final bool bloqueado;

  const CardGato({
    super.key,
    required this.id,
    required this.nome,
    required this.imagem,
    required this.raridade,
    this.equipado = false,
    this.onEquipar,
    required this.bloqueado,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: bloqueado
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => TelaGato(idGato: id, nomeGato: nome, imagemGato: imagem, raridade: raridade),
                ),
              );
            },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                bloqueado
                    ? 'assets/images/$imagem/${imagem}PequenaPB.jpg'
                    : 'assets/images/$imagem/${imagem}Pequena.jpg',
              ),
              const SizedBox(height: 10),
              Text(nome),
              if (!bloqueado)
                ElevatedButtonWidget(
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
                  catColors: equipado
                      ? CatColors(
                          paleta: int.parse(localStorage.getItem("paleta")!),
                        )
                      : CatColors(paleta: 4),
                ),
            ],
          ),
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
    // Inicializa os Futures imediatamente
    GatoServices gatoServices = GatoServices();
    _futureGatos = gatoServices.ListarDesbloqueados();
    _futureGatosBloqueados = gatoServices.ListarBloqueados();
    _carregarDados();
  }

  void _carregarDados() async {
    // Carrega o gato equipado
    GatoServices gatoServices = GatoServices();
    Gato gato = await gatoServices.GatoEquipado();

    setState(() {
      idGatoEquipado = gato.idGato;
      catColors = CatColors(paleta: gato.codPaleta);
    });
  }

  void _equiparGato({required int idGato, required int codPaleta}) {
    localStorage.setItem("gatoEquipado", idGato.toString());
    localStorage.setItem("paleta", codPaleta.toString());
    setState(() {
      idGatoEquipado = idGato;
      catColors = CatColors(paleta: codPaleta);
    });
    GatoServices gatoServices = GatoServices();
    gatoServices.EquiparGato(idGato);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: catColors.complementar,
                        size: 25,
                      ),
                    );
                  },
                ),
                Text("Galeria de Gatos"),
              ],
            ),
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
                          raridade: gato.raridade,
                          equipado: gato.idGato == idGatoEquipado,
                          onEquipar: () => _equiparGato(
                            idGato: gato.idGato,
                            codPaleta: gato.codPaleta,
                          ),
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
                              ? "bloqueado"
                              : gato.nomeImagem,
                          raridade: gato.raridade,
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
      backgroundColor: catColors.primaria,
    );
  }
}
