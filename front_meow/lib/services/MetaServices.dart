import 'dart:convert';

import 'package:front_meow/models/Meta.dart';
import 'package:front_meow/services/ViewModel/Create/CreateMetasViewModel.dart';
import 'package:front_meow/services/ViewModel/View/MetaPorcentagemVIewModel.dart';
import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;

class Metaservices extends Http {
  static String urlMetas = "${Http.url}/metas";

  Future<List<Metas>> listarMetas() async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse('${urlMetas}/listar'),
      headers: Http.headers,
    );
    if (response.statusCode == 200) {
      return List<Metas>.from(
        json.decode(response.body).map((e) => Metas.fromJson(e)),
      );
    } else {
      throw Exception('Erro ao listar Metas');
    }
  }

  Future<List<Metas>> listarMetasClassificao(int idClassificacao) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse('${urlMetas}/listar/classificacao/$idClassificacao'),
      headers: Http.headers,
    );
    if (response.statusCode == 200) {
      List<Metas> metas = List<Metas>.from(
        json.decode(response.body).map((e) => Metas.fromJson(e))
      );
      return metas.where((meta) => meta.feita == 'N').toList();
    } else {
      throw Exception('Erro ao listar Metas por classificação');
    }
  }

  Future<List<Metas>> listarMetasConcluidas() async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse('${urlMetas}/listarConcluidas'),
      headers: Http.headers,
    );
    if (response.statusCode == 200) {
      return List<Metas>.from(
        json.decode(response.body).map((e) => Metas.fromJson(e)),
      );
    } else {
      throw Exception('Erro ao listar Metas concluídas');
    }
  }

  Future<List<Metas>> listarMetasNaoConcluidas() async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse('${urlMetas}/listarNaoConcluidas'),
      headers: Http.headers,
    );
    if (response.statusCode == 200) {
      return List<Metas>.from(
        json.decode(response.body).map((e) => Metas.fromJson(e)),
      );
    } else {
      throw Exception('Erro ao listar Metas não concluídas');
    }
  }

  Future<List<Metas>> listarMetasPorData(DateTime data) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final dataStr = data.toIso8601String();
    final response = await http.get(
      Uri.parse('${urlMetas}/listar/data/$dataStr'),
      headers: Http.headers,
    );
    if (response.statusCode == 200) {
      return List<Metas>.from(
        json.decode(response.body).map((e) => Metas.fromJson(e)),
      );
    } else {
      throw Exception('Erro ao listar Metas por data');
    }
  }

  Future<List<MetasPorcentagemViewModel>> listarMetasComPorcentagem() async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse('${urlMetas}/listar/porcentagem'),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      return List<MetasPorcentagemViewModel>.from(
        json.decode(response.body).map(
              (e) => MetasPorcentagemViewModel.fromJson(e),
        ),
      );
    } else {
      throw Exception('Erro ao listar Metas com porcentagem');
    }
  }

  Future<List<Metas>> listarMetasPorPeriodo(
    DateTime dataInicio,
    DateTime dataFim,
  ) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final inicioStr = dataInicio.toIso8601String();
    final fimStr = dataFim.toIso8601String();
    final response = await http.get(
      Uri.parse('${urlMetas}/listar/periodo/$inicioStr/$fimStr'),
      headers: Http.headers,
    );
    if (response.statusCode == 200) {
      return List<Metas>.from(
        json.decode(response.body).map((e) => Metas.fromJson(e)),
      );
    } else {
      throw Exception('Erro ao listar Metas por período');
    }
  }

  Future<bool> criarMetas(CreateMetasViewModel Metas) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.post(
      Uri.parse('${urlMetas}/criar'),
      headers: Http.headers,
      body: json.encode(Metas.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Erro ao criar Metas: ${response.body}');
    }
  }

  Future<String> deletarMetas(int id) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.delete(
      Uri.parse('${urlMetas}/deletar/$id'),
      headers: Http.headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Erro ao deletar Metas: ${response.body}');
    }
  }

  Future<String> concluirMetas(int id) async {
    if (Http.token == null || Http.token!.isEmpty) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.patch(
      Uri.parse('${urlMetas}/Concluir/$id'),
      headers: Http.headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Erro ao concluir Metas: ${response.body}');
    }
  }
}
