import 'dart:convert';

import 'package:front_meow/models/CreateCofrinhoViewModel.dart';
import 'package:front_meow/model/Cofrinho.dart';
import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;

class CofrinhoServices extends Http {
  static String urlCofrinho = "${Http.url}/cofrinho";
  // Token agora é gerenciado pela classe Http

  //Gets
  Future<List<Cofrinho>> ListarCofrinhos() async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlCofrinho}/listar"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      return List<Cofrinho>.from(
        json.decode(response.body).map((e) => Cofrinho.fromJson(e)),
      );
    } else {
      throw Exception('Failed to load cofrinho');
    }
  }

  Future<List<Cofrinho>> ListarCofrinhosconcluidos() async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlCofrinho}/listarConcluidos"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      return List<Cofrinho>.from(
        json.decode(response.body).map((e) => Cofrinho.fromJson(e)),
      );
    } else {
      throw Exception('Failed to load cofrinho');
    }
  }

  Future<List<Cofrinho>> ListarCofrinhosNaoConcluidos() async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlCofrinho}/listarNaoConcluidos"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      return List<Cofrinho>.from(
        json.decode(response.body).map((e) => Cofrinho.fromJson(e)),
      );
    } else {
      throw Exception('Failed to load cofrinho');
    }
  }

  Future<List<Cofrinho>> ListarCofrinhoPorData(DateTime data) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlCofrinho}/listar/${data.toIso8601String()}"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      return List<Cofrinho>.from(
        json.decode(response.body).map((e) => Cofrinho.fromJson(e)),
      );
    } else {
      throw Exception('Failed to load cofrinho');
    }
  }

  //Posts
  Future<Cofrinho> CriarCofrinho(CreateCofrinhoViewModel cofrinho) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.put(
      Uri.parse("${urlCofrinho}/criar"),
      headers: Http.headers,
      body: jsonEncode(cofrinho.toJson()),
    );

    if (response.statusCode == 201) {
      return Cofrinho.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create cofrinho');
    }
  }

  //Delete
  Future<String> DeletarCofrinho(int id) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.delete(
      Uri.parse("${urlCofrinho}/deletar/$id"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete cofrinho');
    }
  }

  //Patch
  Future<String> ConcluirCofrinho(int id) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.patch(
      Uri.parse("${urlCofrinho}/concluir/$id"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to complete cofrinho');
    }
  }
}
