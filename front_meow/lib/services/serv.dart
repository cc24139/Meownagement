import 'dart:io';

class Http {
  static String url =
      "https://cookiebeco.roney.stein.nom.br/v1"; // colocar a url da api
  static String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImxmNDQ2NTRAZ21haWwuY29tIiwibmFtZWlkIjoiNCIsIm5iZiI6MTc1OTE0NTIxNiwiZXhwIjoxNzU5MTUyNDE2LCJpYXQiOjE3NTkxNDUyMTZ9.ccPVrAcLQaRE1zq5jM1WOpE4X5aNywW35VV0P5dDUU0";
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
