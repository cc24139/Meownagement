import 'dart:io';

class Http {
  static String url =
      "https://cookiebeco.roney.stein.nom.br/v1"; // colocar a url da api
  static String? token = "";
  static Map<String, String> get headers => {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };

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
