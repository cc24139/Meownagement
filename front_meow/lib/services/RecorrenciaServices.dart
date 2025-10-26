import 'dart:io';
import 'package:front_meow/models/recorrencia.dart';
import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class Recorrenciaservices extends Http {
  static String urlRecorrencia = "${Http.url}/recorrencia";
  static String? token = localStorage.getItem('token');

  // Posts

  // Gets

  Future<List<Recorrencia>> ListarRecorrencias() async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlRecorrencia}/listar"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Recorrencia>.from(
        data.map((recorrencia) => Recorrencia.fromJson(recorrencia)),
      );
    } else {
      throw Exception('Failed to load recorrencias');
    }
  }
}
