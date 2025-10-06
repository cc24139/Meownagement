// lib/services/gachaSystem.dart
import 'dart:math';
import 'package:front_meow/services/GatoServices.dart';
import '../models/gato.dart';

class GachaResult {
  final List<Gato> gatos;
  final int raridadeMaisAlta;
  final int rollsTotais;

  GachaResult({
    required this.gatos,
    required this.raridadeMaisAlta,
    required this.rollsTotais,
  });
}

class GachaSystem {
  final Random _random = Random();
  List<Gato> _allGatos = [];
  GatoServices gatoServices = GatoServices();

  // Probabilidades (em porcentagem)
  // final Map<int, double> _rarityProbabilities = {
  //   3: 88.8, // 88.8% chance
  //   4: 10.0, // 10% chance
  //   5: 1.0,  // 1% chance
  //   6: 0.2,  // 0.2% chance
  // };

  GachaSystem() {
    fetchAndInitializeCats();
  }

  // buscar gatos na api e inicializar o sistema
  Future<void> fetchAndInitializeCats() async {
    List<Gato> gatos = await gatoServices.ListarGatos();
    initializeCats(gatos);
  }

  // Inicializar com lista de gatos
  void initializeCats(List<Gato> gatos) {
    _allGatos = gatos;
  }

  // Fazer um roll único
  Future<GachaResult> rollSingle(int banner) async {
    if (_allGatos.isEmpty) {
      throw Exception('GachaSystem não inicializado com gatos');
    }

    int raridade = await _rollRaridadeAsync();
    Gato gato = await _getRandomCatByRarity(raridade, banner);

    return GachaResult(
      gatos: [gato],
      raridadeMaisAlta: raridade,
      rollsTotais: 1,
    );
  }

  // Fazer 10 rolls
  Future<GachaResult> rollMulti(int banner) async {
    if (_allGatos.isEmpty) {
      throw Exception('GachaSystem não inicializado com gatos');
    }

    List<Gato> gatosRolados = [];
    int raridadeMaisAlta = 0;
    List<int> raridades = await _rollRaridadeAsyncMulti(10);

    for (int i = 0; i < 10; i++) {
      int raridade = raridades[i];
      if (raridade > raridadeMaisAlta) raridadeMaisAlta = raridade;
      gatosRolados.add(await _getRandomCatByRarity(raridade, banner));
    }

    return GachaResult(
      gatos: gatosRolados,
      raridadeMaisAlta: raridadeMaisAlta,
      rollsTotais: 10,
    );
  }

  // Roll com garantia de raridade mínima
  Future<GachaResult> rollWithGuarantee(int raridadeMinima, int numeroDeRolls, int banner) async {
    if (_allGatos.isEmpty) {
      throw Exception('GachaSystem não inicializado com gatos');
    }

    List<Gato> gatosRolados = [];
    int raridadeMaisAlta = 0;
    bool garantidoAplicado = false;

    for (int i = 0; i < numeroDeRolls; i++) {
      int raridade;
      
      // Aplica garantia no último roll se necessário
      if (i == numeroDeRolls - 1 && !garantidoAplicado) {
        raridade = raridadeMinima;
        garantidoAplicado = true;
      } else {
        raridade = await _rollRaridadeAsync();
        if (raridade >= raridadeMinima) garantidoAplicado = true;
      }

      if (raridade > raridadeMaisAlta) raridadeMaisAlta = raridade;
      gatosRolados.add(await _getRandomCatByRarity(raridade, banner));
    }

    return GachaResult(
      gatos: gatosRolados,
      raridadeMaisAlta: raridadeMaisAlta,
      rollsTotais: numeroDeRolls,
    );
  }

  // Métodos privados

  Future<int> _rollRaridadeAsync() async {
    int chance = await gatoServices.RoletarPorcentagemUnica();
    
    int raridade = 3;

    // _rarityProbabilities = {
    // 3: 88.8, // 88.8% chance
    // 4: 10.0, // 10% chance
    // 5: 1.0,  // 1% chance
    // 6: 0.2,  // 0.2% chance
    // };
    if (chance <= 2) {
      raridade = 6;
    } else if (chance <= 12) {
      raridade = 5;
    } else if (chance <= 112) {
      raridade = 4;
    } else {
      raridade = 3;
    }
    
    return raridade;
  }

  Future<List<int>> _rollRaridadeAsyncMulti(int numeroDeRolls) async {
    
    // depois mudar para a rota certa
    
    List<int> chances = await gatoServices.RoletarPorcentagemMulti();

    // -----------------------------------------

    List<int> raridades = [];
    for (var chance in chances) {
      int raridade = 3;
      if (chance <= 2) {
        raridade = 6;
      } else if (chance <= 12) {
        raridade = 5;
      } else if (chance <= 112) {
        raridade = 4;
      } else {
        raridade = 3;
      }
      raridades.add(raridade);
    }

    return raridades;
  }

  Future<Gato> _getRandomCatByRarity(int raridade, int bannerAtual) async {
    if (raridade == 5) {
      // gato 5 estrelas sempre do banner atual
      // bannerAtual = idGato

      Gato gatobanner = _allGatos.firstWhere((cat) => cat.idGato == bannerAtual);

      await gatoServices.DesbloquearGato(gatobanner.nome);

      return gatobanner;
    }

    List<Gato> gatosDaRaridade = _allGatos.where((cat) => cat.raridade == raridade).toList();
    if (gatosDaRaridade.isEmpty) {
      // Fallback para qualquer gato se não houver da raridade especificada
      return _allGatos[_random.nextInt(_allGatos.length)];
    }

    Gato gatoObtido = gatosDaRaridade[_random.nextInt(gatosDaRaridade.length)];

    // adiciona o gato a conta do usuário
    await gatoServices.DesbloquearGato(gatoObtido.nome);

    return gatoObtido;
  }
}
