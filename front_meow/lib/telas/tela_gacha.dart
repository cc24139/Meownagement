import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/MeowCoinWidget.dart';
import 'package:front_meow/animations/gachaAnimations.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/Widgets/gachaRollWidget.dart';
import 'package:front_meow/services/gachaSystem.dart';
import 'package:front_meow/models/gachaResult.dart';

class TelaGacha extends StatefulWidget {
  const TelaGacha({super.key});

  @override
  State<TelaGacha> createState() => _TelaGachaState();
}

class _TelaGachaState extends State<TelaGacha> with TickerProviderStateMixin {
  CatColors cores = CatColors(paleta: 4);

  GachaResult? resultadoGacha;
  int bannerAtual = 1;
  GachaSystem? gachaSystem;

  // Controladores de animação
  late AnimationController _previewAnimationController;
  late AnimationController _gatosAnimationController;

  // Estados para controlar as animações
  bool _mostrandoPreview = false;
  bool _mostrandoGatos = false;
  bool _estaRolando = false;

  @override
  void initState() {
    super.initState();

    gachaSystem = GachaSystem();

    // Inicializar os controladores de animação
    _previewAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _gatosAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _previewAnimationController.dispose();
    _gatosAnimationController.dispose();
    super.dispose();
  }

  // Funções de rolls com animações
  void rollUnico() async {
    if (_estaRolando) return;
    
    setState(() {
      _estaRolando = true;
      _mostrandoPreview = true;
      _mostrandoGatos = false;
    });

    resultadoGacha = await gachaSystem?.rollSingle(bannerAtual);

    // Executar animação de preview
    await _previewAnimationController.forward(from: 0.0);

    setState(() {
      _mostrandoPreview = false;
      _mostrandoGatos = true;
    });

    // Executar animação dos gatos
    _gatosAnimationController.forward(from: 0.0);
    
    setState(() {
      _estaRolando = false;
    });
  }

  void rollMulti() async {
    if (_estaRolando) return;
    
    setState(() {
      _estaRolando = true;
      _mostrandoPreview = true;
      _mostrandoGatos = false;
    });

    resultadoGacha = await gachaSystem?.rollMulti(bannerAtual);

    // Executar animação de preview
    await _previewAnimationController.forward(from: 0.0);

    setState(() {
      _mostrandoPreview = false;
      _mostrandoGatos = true;
    });

    // Executar animação dos gatos
    _gatosAnimationController.forward(from: 0.0);
    
    setState(() {
      _estaRolando = false;
    });
  }

  // Função para resetar e voltar ao estado inicial
  void _resetarTela() {
    setState(() {
      _mostrandoPreview = false;
      _mostrandoGatos = false;
      _previewAnimationController.reset();
      _gatosAnimationController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cores.primaria,
      appBar: AppBar(
        backgroundColor: cores.primaria,
        centerTitle: true,
        title: MeowcoinWidget(saldo: 350.75),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nome do Banner",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'LondrinaShadow',
                color: cores.tercearia,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: cores.tercearia,
                  width: 2,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Conteúdo principal que muda baseado no estado
                  if (_mostrandoPreview && resultadoGacha != null)
                    Center(
                      child: GachaAnimations.buildRarityPreview(
                        controller: _previewAnimationController,
                        highestRarity: resultadoGacha!.raridadeMaisAlta,
                        totalCats: resultadoGacha!.gatos.length,
                      ),
                    )
                  else if (_mostrandoGatos && resultadoGacha != null)
                    Center(
                      child: resultadoGacha!.rollsTotais == 1
                          ? GachaRollWidget.buildSingleCatWithInfo(
                              cat: resultadoGacha!.gatos[0],
                              controller: _gatosAnimationController,
                            )
                          : GachaRollWidget.buildMultipleCatsWithAnimation(
                              cats: resultadoGacha!.gatos,
                              controller: _gatosAnimationController,
                            ),
                    )
                  else
                    // Tela inicial com banner e botões
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                        "assets/images/doudouCat/doudouCatGrande.jpg",
                        width: 300,
                        height: 300,
                      ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButtonWidget(
                              text: "Girar 1X",
                              onPressed:() {_estaRolando ? null : rollUnico();},
                              size: ButtonSize.muitoPequeno,
                              catColors: cores,
                            ),
                            const SizedBox(width: 16),
                            ElevatedButtonWidget(
                              text: "Girar 10X",
                              onPressed: () {_estaRolando ? null : rollMulti();},
                              size: ButtonSize.muitoPequeno,
                              catColors: cores,
                            ),
                          ],
                        ),
                        // Botão para resetar se estiver mostrando resultados
                        if (_mostrandoGatos) ...[
                          const SizedBox(height: 16),
                          ElevatedButtonWidget(
                            text: "Voltar",
                            onPressed: _resetarTela,
                            size: ButtonSize.muitoPequeno,
                            catColors: cores,
                          ),
                        ],
                      ],
                    ),

                  // Containers vazando para baixo (só aparecem na tela inicial)
                  if (!_mostrandoPreview && !_mostrandoGatos)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: cores.corTerciaria, width: 2),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: cores.corTerciaria, width: 2),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: cores.corTerciaria, width: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
