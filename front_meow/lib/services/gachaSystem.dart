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
    
    // Cria uma lista de Futures para executar em paralelo
    List<Future<Gato>> futuresGatos = [];
    
    for (int i = 0; i < 10; i++) {
      int raridade = raridades[i];
      // Adiciona o Future à lista sem await
      futuresGatos.add(_getRandomCatByRarity(raridade, banner));
    }

    // Executa TODOS os rolls em paralelo e aguarda todos terminarem
    List<Gato> gatosRolados = await Future.wait(futuresGatos);
    
    // Encontra a raridade mais alta
    int raridadeMaisAlta = raridades.reduce((a, b) => a > b ? a : b);

    return GachaResult(
      gatos: gatosRolados,
      raridadeMaisAlta: raridadeMaisAlta,
      rollsTotais: 10,
    );
  }

  Future<GachaResult> rollMultiAlternativo(int banner) async {
    if (_allGatos.isEmpty) {
      await fetchAndInitializeCats();
    }

    List<int> raridades = await _rollRaridadeAsyncMulti(10);
    
    // Usando map para criar os Futures de forma mais elegante
    List<Future<Gato>> futuresGatos = raridades.map((raridade) {
      return _getRandomCatByRarity(raridade, banner);
    }).toList();

    // Executa em paralelo
    List<Gato> gatosRolados = await Future.wait(futuresGatos);
    
    int raridadeMaisAlta = raridades.reduce((max, current) => current > max ? current : max);

    return GachaResult(
      gatos: gatosRolados,
      raridadeMaisAlta: raridadeMaisAlta,
      rollsTotais: 10,
    );
  }

  // Roll com garantia de raridade mínima
  Future<GachaResult> rollWithGuarantee(int raridadeMinima, int numeroDeRolls, int banner) async {
    if (_allGatos.isEmpty) {
      await fetchAndInitializeCats();
    }

    List<Future<int>> futuresRaridades = [];
    bool garantidoAplicado = false;

    // Primeiro, obtém todas as raridades
    for (int i = 0; i < numeroDeRolls; i++) {
      if (i == numeroDeRolls - 1 && !garantidoAplicado) {
        // Último roll com garantia
        futuresRaridades.add(Future.value(raridadeMinima));
        garantidoAplicado = true;
      } else {
        futuresRaridades.add(_rollRaridadeAsync().then((raridade) {
          if (raridade >= raridadeMinima) garantidoAplicado = true;
          return raridade;
        }));
      }
    }

    List<int> raridades = await Future.wait(futuresRaridades);
    
    // Agora obtém os gatos em paralelo
    List<Future<Gato>> futuresGatos = raridades.map((raridade) {
      return _getRandomCatByRarity(raridade, banner);
    }).toList();

    List<Gato> gatosRolados = await Future.wait(futuresGatos);
    
    int raridadeMaisAlta = raridades.reduce((max, current) => current > max ? current : max);

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
    print(chances);
    
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
      // Fallback para qualquer gato se não houver da raridade especificada
      return _allGatos[_random.nextInt(_allGatos.length)];
    }

    Gato gatoObtido = gatosDaRaridade[_random.nextInt(gatosDaRaridade.length)];
    
    // adiciona o gato a conta do usuário
    await gatoServices.DesbloquearGato(gatoObtido.nome);

    return gatoObtido;
  }
}
