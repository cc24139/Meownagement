import 'dart:io';

class Http {
  static String url =
      "https://cookiebeco.roney.stein.nom.br/v1"; // colocar a url da api
  static String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJvbmV5LnN0ZWluQGdtYWlsLmNvbSIsIm5hbWVpZCI6IjExIiwibmJmIjoxNzYwMzU0NDI5LCJleHAiOjE3NjAzOTA0MjksImlhdCI6MTc2MDM1NDQyOX0.2H5ZjwYmuMvcnMQ9-movsJ3_usLZkraYfVJsyn9IUX4";
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
