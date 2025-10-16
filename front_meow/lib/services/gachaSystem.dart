// lib/services/gachaSystem.dart
import 'dart:math';
import 'package:front_meow/services/GatoServices.dart';
import '../models/gato.dart';
import '../models/gachaResult.dart';

class GachaSystem {
  final Random _random = Random();
  List<Gato> _allGatos = [];
  GatoServices gatoServices = GatoServices();

  GachaSystem() {
    fetchAndInitializeCats();
  }

  Future<void> fetchAndInitializeCats() async {
    List<Gato> gatos = await gatoServices.ListarGatos();  
    initializeCats(gatos);
  }

  void initializeCats(List<Gato> gatos) {
    _allGatos = gatos;
  }

  // Fazer um roll único
  Future<GachaResult> rollSingle(int banner) async {
    if (_allGatos.isEmpty) {
      await fetchAndInitializeCats();
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
      await fetchAndInitializeCats();
    }

    List<int> raridades = await _rollRaridadeAsyncMulti(10);
    
    List<Future<Gato>> futuresGatos = [];
    
    for (int i = 0; i < 10; i++) {
      int raridade = raridades[i];
      futuresGatos.add(_getRandomCatByRarity(raridade, banner));
    }

    List<Gato> gatosRolados = await Future.wait(futuresGatos);
    
    int raridadeMaisAlta = raridades.reduce((a, b) => a > b ? a : b);

    return GachaResult(
      gatos: gatosRolados,
      raridadeMaisAlta: raridadeMaisAlta,
      rollsTotais: 10,
    );
  }

  // Métodos privados
  Future<int> _rollRaridadeAsync() async {
    int chance = await gatoServices.RoletarPorcentagemUnica();
    
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
    
    return raridade;
  }

  Future<List<int>> _rollRaridadeAsyncMulti(int numeroDeRolls) async {
    List<int> chances = await gatoServices.RoletarPorcentagemMulti();
    
    if (chances.length != numeroDeRolls) {
      throw Exception('Número de rolls retornados não corresponde ao esperado');
    }

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
      Gato gatobanner = _allGatos.firstWhere((cat) => cat.idGato == bannerAtual);
      await gatoServices.DesbloquearGato(gatobanner.nome);
      return gatobanner;
    }

    List<Gato> gatosDaRaridade = _allGatos.where((cat) => cat.raridade == raridade).toList();

    if (gatosDaRaridade.isEmpty) {
      List<Gato> gatosRaridadeInferior = _allGatos.where((cat) => cat.raridade < raridade).toList();
      
      if (gatosRaridadeInferior.isNotEmpty) {
        Gato gatoFallback = gatosRaridadeInferior[_random.nextInt(gatosRaridadeInferior.length)];
        await gatoServices.DesbloquearGato(gatoFallback.nome);
        return gatoFallback;
      } else {
        // Último recurso: qualquer gato
        Gato gatoFallback = _allGatos[_random.nextInt(_allGatos.length)];
        await gatoServices.DesbloquearGato(gatoFallback.nome);
        return gatoFallback;
      }
    }

    Gato gatoObtido = gatosDaRaridade[_random.nextInt(gatosDaRaridade.length)];
    
    await gatoServices.DesbloquearGato(gatoObtido.nome);

    return gatoObtido;
  }
}
