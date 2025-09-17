import 'package:http/http.dart' as http;
import 'dart:convert';

class Http {
  static String url = "http://"; // colocar a url da api

  // exemplo -> dps poem as rotas reias aqui
  static getUsuario() async {
    final res = await http.get(Uri.parse("#{url}/usuario"));

    if (res.statusCode == 200) {
      
      var data = jsonDecode(res.body.toString());
      return data;

    } else {
      throw Exception("Erro ao carregar usuarios");
    }
  }
}
