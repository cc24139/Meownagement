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

  // Funções de rolls com animações - CORRIGIDAS
  void rollUnico() async {
    if (_estaRolando) return;
    
    setState(() {
      _estaRolando = true;
      _mostrandoPreview = true;
      _mostrandoGatos = false;
    });

    resultadoGacha = await gachaSystem?.rollSingle(bannerAtual);

    // DEBUG: Verificar se o resultado chegou
    print('Roll único - Raridade mais alta: ${resultadoGacha?.raridadeMaisAlta}');
    print('Roll único - Total de gatos: ${resultadoGacha?.gatos.length}');

    // RESETAR E EXECUTAR animação de preview
    _previewAnimationController.reset();
    await _previewAnimationController.forward();

    // Aguardar um pouco antes de mostrar os gatos
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _mostrandoPreview = false;
      _mostrandoGatos = true;
    });

    // RESETAR E EXECUTAR animação dos gatos
    _gatosAnimationController.reset();
    _gatosAnimationController.forward();
  }

  void rollMulti() async {
    if (_estaRolando) return;
    
    setState(() {
      _estaRolando = true;
      _mostrandoPreview = true;
      _mostrandoGatos = false;
    });

    resultadoGacha = await gachaSystem?.rollMulti(bannerAtual);

    // DEBUG: Verificar se o resultado chegou
    print('Roll múltiplo - Raridade mais alta: ${resultadoGacha?.raridadeMaisAlta}');
    print('Roll múltiplo - Total de gatos: ${resultadoGacha?.gatos.length}');

    // RESETAR E EXECUTAR animação de preview
    _previewAnimationController.reset();
    await _previewAnimationController.forward();

    // Aguardar um pouco antes de mostrar os gatos
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _mostrandoPreview = false;
      _mostrandoGatos = true;
    });

    // RESETAR E EXECUTAR animação dos gatos
    _gatosAnimationController.reset();
    _gatosAnimationController.forward();
  }

  // Função para resetar e voltar ao estado inicial
  void _resetarTela() {
    setState(() {
      _mostrandoPreview = false;
      _mostrandoGatos = false;
      _estaRolando = false;
      _previewAnimationController.reset();
      _gatosAnimationController.reset();
    });
  }

  // Widget para overlay dos resultados (aparece por cima)
  Widget _buildOverlayResultados() {
    if (!_mostrandoGatos || resultadoGacha == null) return const SizedBox();

    return Stack(
      children: [
        // Fundo semi-transparente que fecha ao clicar
        GestureDetector(
          onTap: _resetarTela,
          child: Container(
            color: Colors.black54,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        
        // Conteúdo centralizado dos resultados
        Center(
          child: Container(
            width: 350,
            height: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Conteúdo dos gatos
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: resultadoGacha!.rollsTotais == 1
                        ? GachaRollWidget.buildSingleCatWithInfo(
                            cat: resultadoGacha!.gatos[0],
                            controller: _gatosAnimationController,
                          )
                        : GachaRollWidget.buildMultipleCatsWithAnimation(
                            cats: resultadoGacha!.gatos,
                            controller: _gatosAnimationController,
                          ),
                  ),
                ),
                
                // Botão de fechar no canto superior direito
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: cores.primaria,
                        shape: BoxShape.circle,
                        border: Border.all(color: cores.tercearia, width: 2),
                      ),
                      child: Icon(Icons.close, color: cores.tercearia, size: 20),
                    ),
                    onPressed: _resetarTela,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
      body: Stack(
        children: [
          // Conteúdo principal da tela
          Center(
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
                      else
                        // Tela inicial com banner e botões (sempre visível)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/watermelonZazu/watermelonZazuGrande.jpg",
                              width: 200,
                              height: 200,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButtonWidget(
                                  text: "Girar 1X",
                                  onPressed: () {_estaRolando ? null : rollUnico();},
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

          // Overlay dos resultados (aparece por cima quando necessário)
          _buildOverlayResultados(),
        ],
      ),
    );
  }
}
