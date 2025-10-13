import 'package:flutter/material.dart';
import 'package:front_meow/Widgets/ElevatedButtonWidget.dart';
import 'package:front_meow/Widgets/MenuLateralWidget.dart';
import 'package:front_meow/Widgets/MeowCoinWidget.dart';
import 'package:front_meow/animations/gachaAnimations.dart';
import 'package:front_meow/colors/colors.dart';
import 'package:front_meow/Widgets/Tools/ButtonSize.dart';
import 'package:front_meow/Widgets/gachaRollWidget.dart';
import 'package:front_meow/services/gachaSystem.dart';
import 'package:front_meow/models/gachaResult.dart';
import 'package:front_meow/services/UsuarioServices.dart';

class TelaGacha extends StatefulWidget {
  const TelaGacha({super.key});

  @override
  State<TelaGacha> createState() => _TelaGachaState();
}

class _TelaGachaState extends State<TelaGacha> with TickerProviderStateMixin {
  CatColors cores = CatColors(paleta: 4);

  // parte do gacha

  int meowCoins = 0;

  GachaResult? resultadoGacha;
  int bannerAtual = 15; // id do banner deve ser o idGato do gato de banner -> 13 14 15
  GachaSystem? gachaSystem;

  late AnimationController _previewAnimationController;
  late AnimationController _gatosAnimationController;

  bool _mostrandoPreview = false;
  bool _mostrandoGatos = false;
  bool _estaRolando = false;
  bool _carregandoRoll = false;

  void atualizarMeowCoins() {
     UsuarioServices().PerfilUsuario().then((usuario) {
      setState(() {
        meowCoins = usuario.pontos;
      });
    });
  }

  String nomeDoBannerAtual() {
    switch (bannerAtual) {
      case 13:
        return '"Hello vro" MeiMei';
      case 14:
        return "Odisseia melancia do Zazu";
      case 15:
        return "I'm a new Meowl";
      default:
        return "Banner Desconhecido";
    }
  }

  String imagemBannerAtual() {
    switch (bannerAtual) {
      case 13:
        return "assets/images/meimei/meimeiGrande.jpg";
      case 14:
        return "assets/images/watermelonZazu/watermelonZazuGrande.jpg";
      case 15:
        return "assets/images/meowl/meowlGrande.jpg";
      default:
        return "assets/images/ponderingCat/ponderingCatGrande.jpg";
    }
  }

  @override
  void initState() {
    super.initState();

    atualizarMeowCoins();
    gachaSystem = GachaSystem();

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

  void rollUnico() async {
    if (_estaRolando) return;
    
    _resetarParaNovoRoll();
    
    setState(() {
      _estaRolando = true;
      _carregandoRoll = true;
    });

    try {
      resultadoGacha = await gachaSystem?.rollSingle(bannerAtual);
    } catch (e) {
      print("Erro ao realizar roll único: $e");
    }

    atualizarMeowCoins();

    setState(() {
      _carregandoRoll = false;
      _mostrandoPreview = true;
    });

    _previewAnimationController.reset();
    await _previewAnimationController.forward();

    setState(() {
      _mostrandoPreview = false;
      _mostrandoGatos = true;
    });

    _gatosAnimationController.reset();
    _gatosAnimationController.forward();
    
    setState(() {
      _estaRolando = false;
    });
  }

  void rollMulti() async {
    if (_estaRolando) return;
    
    _resetarParaNovoRoll();
    
    setState(() {
      _estaRolando = true;
      _carregandoRoll = true;
    });

    try {
      resultadoGacha = await gachaSystem?.rollMulti(bannerAtual);
    } catch (e) {
      print("Erro ao realizar roll múltiplo: $e");
    }

    atualizarMeowCoins();

    setState(() {
      _carregandoRoll = false;
      _mostrandoPreview = true;
    });

    _previewAnimationController.reset();
    await _previewAnimationController.forward();

    setState(() {
      _mostrandoPreview = false;
      _mostrandoGatos = true;
    });

    _gatosAnimationController.reset();
    _gatosAnimationController.forward();
    
    setState(() {
      _estaRolando = false;
    });
  }

  void _resetarTela() {
    setState(() {
      _mostrandoPreview = false;
      _mostrandoGatos = false;
      _estaRolando = false;
      _previewAnimationController.reset();
      _gatosAnimationController.reset();
    });
  }

  void _resetarParaNovoRoll() {
    setState(() {
      _mostrandoPreview = false;
      _mostrandoGatos = false;
      _estaRolando = false;
      _carregandoRoll = false;
      resultadoGacha = null;
      _previewAnimationController.reset();
      _gatosAnimationController.reset();
    });
  }

  Widget _buildOverlayResultados() {
    if (!_mostrandoGatos || resultadoGacha == null) return const SizedBox();

    return Stack(
      children: [
        GestureDetector(
          onTap: _resetarTela,
          child: Container(
            color: Colors.black54,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        
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

  Widget _buildConteudoPrincipal() {
    if (_carregandoRoll) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: cores.tercearia),
            const SizedBox(height: 16),
            Text(
              'Roletando...',
              style: TextStyle(
                fontSize: 16,
                color: cores.tercearia,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    if (_mostrandoPreview && resultadoGacha != null) {
      return Center(
        child: GachaAnimations.buildRarityPreview(
          controller: _previewAnimationController,
          highestRarity: resultadoGacha!.raridadeMaisAlta,
          totalCats: resultadoGacha!.gatos.length,
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagemBannerAtual(),
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
              highSize: ButtonSize.muitoPequeno,
              weightSize: ButtonSize.pequeno,
              catColors: cores,
            ),
            const SizedBox(width: 16),
            ElevatedButtonWidget(
              text: "Girar 10X",
              onPressed: () {_estaRolando ? null : rollMulti();},
              highSize: ButtonSize.muitoPequeno,
              weightSize: ButtonSize.pequeno,
              catColors: cores,
            ),
          ],
        ),
      ],
    );
  }

  // termina o gacha --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cores.primaria,
      appBar: AppBar(
        backgroundColor: cores.primaria,
        centerTitle: true,
        title: MeowcoinWidget(saldo: meowCoins),
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
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Text(
                  nomeDoBannerAtual(),
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'LondrinaShadow',
                    color: cores.tercearia,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 380,
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
                      _buildConteudoPrincipal(),

                      if (!_mostrandoPreview && !_mostrandoGatos && !_carregandoRoll)
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: -60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: cores.corTerciaria, width: 2),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: cores.corTerciaria, width: 2),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: cores.corTerciaria, width: 2),
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

          _buildOverlayResultados(),
        ],
      ),
      drawer: Menulateralwidget(),
    );
  }
}
