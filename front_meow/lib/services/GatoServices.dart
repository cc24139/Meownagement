import 'dart:io';
import 'package:front_meow/models/gato.dart';
import 'package:front_meow/services/ViewModel/GatosEstaticasViewModel.dart';
import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GatoServices extends Http {
  static String urlGato = "${Http.url}/gatos";
  // Token agora é gerenciado pela classe Http
  // GETS
  Future<List<Gato>> ListarGatos() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listar"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Gato>.from(data.map((gato) => Gato.fromJson(gato)));
    } else {
      throw Exception('Failed to load gatos');
    }
  }

  Future<Gato> BuscarGatoPorId(int id) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listarIdGato/$id"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Gato.fromJson(data);
    } else {
      throw Exception('Failed to load gato');
    }
  }

  Future<List<Gato>> BuscarGatosPorNome(String nome) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listarNome/$nome"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Gato>.from(data.map((gato) => Gato.fromJson(gato)));
    } else {
      throw Exception('Failed to load gatos');
    }
  }

  Future<List<Gato>> BuscarGatosRaridade(int raridade) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listarRaridade?raridade=$raridade"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Gato>.from(data.map((gato) => Gato.fromJson(gato)));
    } else {
      throw Exception('Failed to load gatos');
    }
  }

  Future<GatosEstaticasViewModel> EstaticasGatosId(int id) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/estaticas/$id"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GatosEstaticasViewModel.fromJson(data);
    } else {
      throw Exception('Failed to load gatos estaticos');
    }
  }

  Future<List<Gato>> ListarDesbloqueados() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listarDesbloqueados"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Gato>.from(data.map((gato) => Gato.fromJson(gato)));
    } else {
      throw Exception('Failed to load gatos desbloqueados');
    }
  }

  Future<List<Gato>> ListarBloqueados() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listarBloqueados"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Gato>.from(data.map((gato) => Gato.fromJson(gato)));
    } else {
      throw Exception('Failed to load gatos bloqueados');
    }
  }

  Future<int> RoletarPorcentagemUnica() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/roletar"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to roletar gato');
    }
  }

  Future<List<int>> RoletarPorcentagemMulti() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    
    final response = await http.get(
      Uri.parse("${urlGato}/roletar/10"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      List<int> result = List<int>.from(data);
      
      print('Porcentagens recebidas: $result');
      return result;
    } 
    else {
      throw Exception('Failed to roletar gatos: ${response.statusCode}');
    }
  }

  Future<Gato> GatoEquipado() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/equipado"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Gato.fromJson(data);
    } else {
      throw Exception('Failed to load gato equipado');
    }
  }

  Future<bool> EquiparGato(int id) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.patch(
      Uri.parse("${urlGato}/equipar/$id"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    return response.statusCode == 200;
  }

  Future<int> PaletaId(int id) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/paleta/$id"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load paleta id');
    }
  }

  Future<int> PaletaEquipado() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/paleta/usuario"),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${Http.token}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Paleta: "+ data.toString());
      return data;
    } else {
      throw Exception('Failed to load paleta id');
    }
  }

  //Post
  Future<bool> DesbloquearGato(String nome) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.post(
      Uri.parse("${urlGato}/adicionar"),
      headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${Http.token}',
      'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(nome),
    );

    if (response.statusCode == 200) {
      print('Gato desbloqueado: $nome');
    }
    else {
      print('Failed to desbloquear gato: $nome, Status code: ${response.statusCode}');
    }

    return response.statusCode == 200;
  }
} 
