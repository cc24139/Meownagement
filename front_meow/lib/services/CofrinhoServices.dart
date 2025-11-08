import 'dart:convert';
import 'dart:core';

import 'package:front_meow/models/Cofrinho.dart';
import 'package:front_meow/services/ViewModel/Create/CreateCofrinhoViewModel.dart';
import 'package:front_meow/services/ViewModel/View/CofrinhoPorcentagemViewModel.dart';
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

  Future<List<CofrinhoPorcentagemViewModel>>
  ListarCofrinhosPorcentagem() async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlCofrinho}/listarPorcentagem"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> lista = data['listCofrinhoViewm'] ?? [];
      return List<CofrinhoPorcentagemViewModel>.from(
        lista.map((e) => CofrinhoPorcentagemViewModel.fromJson(e)),
      );
    } else {
      throw Exception('Failed to load cofrinho porcentagem');
    }
  }

  Future<List<Cofrinho>> ListarCofrinhosClassificacao(
    int idClassificacao,
  ) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlCofrinho}/listar/classificacao/$idClassificacao"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      // Converte o JSON para lista de Cofrinho e filtra apenas os não concluídos
      final List<Cofrinho> todosCofrinhos = List<Cofrinho>.from(
        json.decode(response.body).map((e) => Cofrinho.fromJson(e)),
      );

      // Filtra apenas os cofrinhos não concluídos (feita == 'N')
      return todosCofrinhos.where((cofrinho) => cofrinho.feita == 'N').toList();
    } else {
      throw Exception('Failed to load cofrinho');
    }
  }

  Future<List<Cofrinho>> ListarCofrinhosConcluidos() async {
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
      Uri.parse("${urlCofrinho}/listar/data/${data.toIso8601String()}"),
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
      throw Exception('Falha ao concluir o cofrinho: ${response.body.toString()}');
    }
  }
}
