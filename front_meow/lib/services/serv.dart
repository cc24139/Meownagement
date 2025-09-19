import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:front_meow/model/usuario.dart';

class Http {
  static String url = "http://"; // colocar a url da api

  // exemplo -> dps poem as rotas reias aqui
  Future<List<Usuario>> fetchUsuarios() async {
    final response = await http.get(Uri.parse('${url}/usuarios'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Usuario.fromJson(data)).toList();
    } else {
      throw Exception('Erro ao carregar usuários');
    }
  }

  /*

  para chamar nas telas:

  const Http = Http(); // classe http para usar as rotas

  var usuarios = await Http.fetchUsuarios();

  // ou

  await Http.fetchUsuarios().then((value) {
    usuarios = value;
  });

  print(usuarios[0].nome);


  */
}
