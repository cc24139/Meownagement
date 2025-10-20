import 'dart:io';
import 'package:front_meow/models/login_diario.dart';
import 'package:front_meow/services/serv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Logindiarioservices extends Http {
  static String urlLogin = "${Http.url}/loginDiario";
  // Gets
  Future<List<LoginDiario>> ListarLoginDiario() async {
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.get(
      Uri.parse("${urlLogin}/listar"),
      headers: {HttpHeaders.authorizationHeader: Http.token!},
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
    print(Http.token);
    if (Http.token == null) {
      throw Exception('Você foi deslogado, por favor faça login novamente.');
    }
    final response = await http.patch(
      Uri.parse("${urlLogin}/atualizar"),
      headers: Http.headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['mensagem']);
    }
    else if (response.statusCode == 400) {
      return ("Já realizou o login diário hoje.");
    }
    else {
      throw Exception('Failed to update login diario');
    }
  }
}
