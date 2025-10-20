import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:front_meow/models/transacao.dart';
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
    String DataFinalizacao,
    int? IdRecorrencia,
    int IdClassificacao,
    int? idMeta,
    int? idCofrinho,
  ) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }

    final body = {
      'Nome': Nome,
      'QuantiaDinheiro': QuantiaDinheiro,
      'Feita': 'N',
      'DataFinalizacao': DataFinalizacao,
      'IdRecorrencia': IdRecorrencia,
      'IdClassificacao': IdClassificacao,
      'IdMeta': idMeta,
      'IdCofrinho': idCofrinho,
    };

    final response = await http.post(
      Uri.parse("${urlTransacao}/criar"),
      headers: Http.headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ("Transação criada com sucesso");
    }
    throw Exception(
      'Failed to create transacao: ${response.statusCode} ${response.body}',
    );
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

  //Teste necessario
  Future<List<Transacao>> ListarPorDate(DateTime date) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    // API expects date in yyyy-MM-dd format in route
    final dateStr = date.toIso8601String().split('T').first;
    final response = await http.get(
      Uri.parse("${urlTransacao}/listar/$dateStr"),
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

  Future<List<Transacao>> ListarPorPeriodo(DateTime start, DateTime end) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final startStr = start.toIso8601String().split('T').first;
    final endStr = end.toIso8601String().split('T').first;
    final response = await http.get(
      Uri.parse("${urlTransacao}/listar/$startStr/$endStr"),
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

  Future<List<Transacao>> ListarPositivas() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlTransacao}/listar/positivo"),
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

  Future<List<Transacao>> ListarNegativas() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlTransacao}/listar/negativo"),
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

  //Patches
  Future<String> EditarTransacao(
    int Id,
    String Nome,
    double QuantiaDinheiro,
    DateTime DataCriacao,
    DateTime DataFinalizacao,
    int? IdRecorrencia,
    int IdClassificacao,
    int? idMeta,
    int? idCofrinho,
  ) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }

    final body = {
      'IdTransacao': Id,
      'Nome': Nome,
      'QuantiaDinheiro': QuantiaDinheiro,
      'DataCriacao': DataCriacao.toIso8601String(),
      'Feita': 'N',
      'DataFinalizacao': DataFinalizacao.toIso8601String(),
      'IdClassificacao': IdClassificacao,
      'IdRecorrencia': IdRecorrencia,
      'IdMeta': idMeta,
      'IdCofrinho': idCofrinho,
    };

    final response = await http.patch(
      Uri.parse("${urlTransacao}/editar"),
      headers: Http.headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return ("Transação editada com sucesso");
    }
    throw Exception(
      'Failed to edit transacao: ${response.statusCode} ${response.body}',
    );
  }

  Future<String> AtualizarSaldo(int id) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }

    final response = await http.patch(
      Uri.parse("${urlTransacao}/atualizar/saldo/$id"),
      headers: Http.headers,
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
      headers: Http.headers,
    );

    if (response.statusCode == 204 || response.statusCode == 200) {
      return ("Transação deletada com sucesso");
    }
    throw Exception(
      'Failed to delete transacao: ${response.statusCode} ${response.body}',
    );
  }

  Future<String> AtualizarTransaceos(int id) async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }

    final response = await http.get(
      Uri.parse(
        "${Http.url.replaceAll('/transacoes', '')}/transacao/atualizar",
      ),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      return ("Transações atualizadas com sucesso");
    }
    throw Exception(
      'Failed to update transacoes: ${response.statusCode} ${response.body}',
    );
  }
}
