import 'dart:io';

import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:front_meow/model/transacao.dart';

import 'package:localstorage/localstorage.dart';

class TransacaoServices extends Http {
  static String urlTransacao = "${Http.url}/transacoes";

  TransacaoServices() {
    Http.token = localStorage.getItem('Http.token');
  }

  // Posts
  Future<String> CriarTransacao(
    String Nome,
    double QuantiaDinheiro,
    String DataCriacao,
    String DataFinalizacao,
    int IdOcorrencia,
    int IdClassificacao,
  ) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }

    final response = await http.post(
      Uri.parse("${urlTransacao}/criar"),
      headers: Http.headers,
      body: jsonEncode({
        'nome': Nome,
        'quantiaDinheiro': QuantiaDinheiro,
        'dataCriacao': DataCriacao,
        'dataFinalizacao': DataFinalizacao,
        'idOcorrencia': IdOcorrencia,
        'idClassificacao': IdClassificacao,
      }),
    );

    if (response.statusCode == 201) {
      return ("Transação criada com sucesso");
    } else {
      throw Exception('Failed to create transacao');
    }
  }

  // Gets
  Future<List<Transacao>> ListarTransacoes() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlTransacao}/listar"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Transacao>.from(
        data.map((transacao) => Transacao.fromJson(transacao)),
      );
    } else {
      throw Exception('Failed to load transacao');
    }
  }

  Future<List<Transacao>> ListarTransacoesRecorrentes() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlTransacao}/listar/recorrentes"),
      headers:  Http.headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Transacao>.from(
        data.map((transacao) => Transacao.fromJson(transacao)),
      );
    } else {
      throw Exception('Failed to load transacao');
    }
  }

  //Teste necessario
  Future<List<Transacao>> ListarPorDate(DateTime date) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlTransacao}/listar/porData/${date.toIso8601String()}"),
      headers:  Http.headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Transacao>.from(
        data.map((transacao) => Transacao.fromJson(transacao)),
      );
    } else {
      throw Exception('Failed to load transacao');
    }
  }

  Future<List<Transacao>> ListarPorPeriodo(DateTime start, DateTime end) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse(
        "${urlTransacao}/listar/porPeriodo/${start.toIso8601String()}/${end.toIso8601String()}",
      ),
      headers:  Http.headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Transacao>.from(
        data.map((transacao) => Transacao.fromJson(transacao)),
      );
    } else {
      throw Exception('Failed to load transacao');
    }
  }

  Future<List<Transacao>> ListarPositivas() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlTransacao}/listar/positivo"),
      headers:  Http.headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Transacao>.from(
        data.map((transacao) => Transacao.fromJson(transacao)),
      );
    } else {
      throw Exception('Failed to load transacao');
    }
  }

  Future<List<Transacao>> ListarNegativas() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlTransacao}/listar/negativo"),
     headers:  Http.headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Transacao>.from(
        data.map((transacao) => Transacao.fromJson(transacao)),
      );
    } else {
      throw Exception('Failed to load transacao');
    }
  }

  //Patches
  Future<String> EditarTransacao(
    int Id,
    String Nome,
    double QuantiaDinheiro,
    String DataCriacao,
    String DataFinalizacao,
    int IdOcorrencia,
    int IdClassificacao,
    int? idMeta,
    int? idCofrinho,
  ) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }

    final response = await http.patch(
      Uri.parse("${urlTransacao}/editar/$Id"),
     headers:  Http.headers,
      body: jsonEncode({
        'IdTransacao': Id,
        'Nome': Nome,
        'QuantiaDinheiro': QuantiaDinheiro,
        'DataCriacao': DataCriacao,
        'DataFinalizacao': DataFinalizacao,
        'IdClassificacao': IdClassificacao,
        'IdRecorrencia': IdOcorrencia,
        'IdMeta': idMeta,
        'IdCofrinho': idCofrinho,
      }),
    );

    if (response.statusCode == 200) {
      return ("Transação editada com sucesso");
    } else {
      throw Exception('Failed to edit transacao');
    }
  }

  Future<String> AtualizarSaldo(int id) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }

    final response = await http.patch(
      Uri.parse("${urlTransacao}/atualizar/saldo/$id"),
      headers:  Http.headers,
    );

    if (response.statusCode == 200) {
      return ("Saldo atualizado com sucesso");
    } else {
      throw Exception('Failed to update saldo');
    }
  }

  //delete
  Future<String> DeletarTransacao(int id) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }

    final response = await http.delete(
      Uri.parse("${urlTransacao}/deletar/$id"),
     headers:  Http.headers,
    );

    if (response.statusCode == 200) {
      return ("Transação deletada com sucesso");
    } else {
      throw Exception('Failed to delete transacao');
    }
  }

  
  Future<String> AtualizarTransaceos(int id) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }

    final response = await http.patch(
      Uri.parse("${urlTransacao}/atualizar"),
      headers:  Http.headers,
    );

    if (response.statusCode == 200) {
      return ("Transações atualizadas com sucesso");
    } else {
      throw Exception('Failed to update transacoes');
    }
  }

}
