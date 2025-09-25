import 'dart:io';

import 'package:front_meow/model/gato.dart';
import 'package:front_meow/model/login_diario.dart';
import 'package:front_meow/services/ViewModel/GatosEstaticasViewModel.dart';
import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:front_meow/model/transacao.dart';

import 'package:localstorage/localstorage.dart';

class GatoServices extends Http {
  static String urlGato = "${Http.url}/gatos";
  static String? token = localStorage.getItem('token');

  // GETS
  Future<List<Gato>> ListarGatos() async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listar"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Gato>.from(data.map((gato) => Gato.fromJson(gato)));
    } else {
      throw Exception('Failed to load gatos');
    }
  }

  Future<Gato> BuscarGatoPorId(int id) async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/buscar/$id"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Gato.fromJson(data);
    } else {
      throw Exception('Failed to load gato');
    }
  }

  Future<List<Gato>> BuscarGatosPorNome(String nome) async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listarNome/$nome"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Gato>.from(data.map((gato) => Gato.fromJson(gato)));
    } else {
      throw Exception('Failed to load gatos');
    }
  }

  Future<List<Gato>> BuscarGatosRaridade(int raridade) async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listarRaridade?raridade=$raridade"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Gato>.from(data.map((gato) => Gato.fromJson(gato)));
    } else {
      throw Exception('Failed to load gatos');
    }
  }

  Future<GatosEstaticasViewModel> EstaticasGatosId(int id) async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/estaticas/$id"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GatosEstaticasViewModel.fromJson(data);
    } else {
      throw Exception('Failed to load gatos estaticos');
    }
  }

  Future<List<Gato>> ListarDesbloqueados() async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listarDesbloqueados"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Gato>.from(data.map((gato) => Gato.fromJson(gato)));
    } else {
      throw Exception('Failed to load gatos desbloqueados');
    }
  }

  Future<List<Gato>> ListarBloqueados() async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/listarBloqueados"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Gato>.from(data.map((gato) => Gato.fromJson(gato)));
    } else {
      throw Exception('Failed to load gatos bloqueados');
    }
  }

  Future<int> RoletarPorcentagem() async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/roletarPorcentagem"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to roletar gato');
    }
  }

  Future<Gato> GatoEquipado() async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/equipado"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Gato.fromJson(data);
    } else {
      throw Exception('Failed to load gato equipado');
    }
  }

  Future<bool> EquiparGato(int id) async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.put(
      Uri.parse("${urlGato}/equipar/$id"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    return response.statusCode == 200;
  }

  Future<int> PaletaId(int id) async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/paleta/$id"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load paleta id');
    }
  }

  Future<int> PaletaEquipado() async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlGato}/paleta/usuario"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load paleta id');
    }
  }

  //Post
  Future<bool> DesbloquearGato(String nome) async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.post(
      Uri.parse("${urlGato}/adicionar"),
      headers: {HttpHeaders.authorizationHeader: token!},
      body: jsonEncode({'Nome': nome}),
    );

    return response.statusCode == 200;
  }
}
