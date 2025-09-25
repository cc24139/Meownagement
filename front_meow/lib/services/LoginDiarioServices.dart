import 'dart:io';

import 'package:front_meow/model/login_diario.dart';
import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:front_meow/model/transacao.dart';

import 'package:localstorage/localstorage.dart';

class Logindiarioservices extends Http {
  static String urlLogin = "${Http.url}/loginDiario";
  static String? token = localStorage.getItem('token');

  // Gets
  Future<List<LoginDiario>> ListarLoginDiario() async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlLogin}/listar"),
      headers: {HttpHeaders.authorizationHeader: token!},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<LoginDiario>.from(
        data.map((login) => LoginDiario.fromJson(login)),
      );
    } else {
      throw Exception('Failed to load login diario');
    }
  }
  //patch
  Future<String> AtualizarLoginDiario() async {
    if (token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.patch(
      Uri.parse("${urlLogin}/atualizar"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token!,
      },
    );

    if (response.statusCode == 200) {
      return ("Login diario atualizado com sucesso");
    } else {
      throw Exception('Failed to update login diario');
    }
  }
}
